require "mixins/periodic/nourishment_burner/definition"
require "mixins/characters/physical_attrs/races/definition"
require "mixins/characters/physical_attrs/genders/definition"
require "mixins/characters/nourishment/definition"

module ChatoMud
  module Controllers
    module Characters
      class NourishmentController
        include Mixins::Periodic::NourishmentBurner::Definition
        include Mixins::Characters::PhysicalAttrs::Races::Definition
        include Mixins::Characters::PhysicalAttrs::Genders::Definition
        include Mixins::Characters::Nourishment::Definition

        def initialize(server, character_controller, nourishment)
          @server = server

          @character_controller = character_controller

          @nourishment = nourishment

          @burn_rate = find_burn_rate
        end

        def calories
          @nourishment.calories
        end

        def max_calories
          value  = race_caloric_needs_base[@character_controller.physical_attr_controller.race.to_sym]

          value *= gender_caloric_needs_multiplier[@character_controller.physical_attr_controller.gender.to_sym]

          value.round
        end

        def hunger_percentage(calories_value)
          calories_value / max_calories.to_f
        end

        def hunger_stage(calories_value = nil)
          calories_value = calories if calories_value.nil?

          (hunger_percentage(calories_value) * 10).floor.clamp(0, 9)
        end

        def hunger_stage_description(hunger_stage_value = nil)
          hunger_stage_value = hunger_stage if hunger_stage_value.nil?

          all_hunger_stages[hunger_stage_value]
        end

        def hydration
          @nourishment.hydration
        end

        def max_hydration
          2500 # In milliliters.
        end

        def thirst_percentage(hydration_value)
          hydration_value / max_hydration.to_f
        end

        def thirst_stage(hydration_value = nil)
          hydration_value = hydration if hydration_value.nil?

          (thirst_percentage(hydration_value) * 10).floor.clamp(0, 9)
        end

        def thirst_stage_description(thirst_stage_value = nil)
          thirst_stage_value = thirst_stage if thirst_stage_value.nil?

          all_thirst_stages[thirst_stage_value]
        end

        def auto_burn_nourishment
          update_nourishment(-@burn_rate[:calories], -@burn_rate[:hydration])
        end

        def replenish_nourishment(calories, hydration)
          update_nourishment(calories, hydration)
        end

        def consume_nourishment(calories, hydration)
          update_nourishment(-calories, -hydration)
        end

        def penalty
          hunger_penalties[hunger_stage] + thirst_penalties[thirst_stage]
        end

        private

        def find_burn_rate
          times_per_day = 24 * 60 * 60 / (Mixins::Periodic::NourishmentBurner::Definition::REFRESH_INTERVAL * 4)

          {
            calories:  (max_calories  / times_per_day.to_f).round,
            hydration: (max_hydration / times_per_day.to_f).round
          }
        end

        def update_nourishment(calories_modifier, hydration_modifier)
          send_nourishment_message(calories_modifier, hydration_modifier)

          @nourishment.calories  = (@nourishment.calories  + calories_modifier).clamp(0, max_calories)

          @nourishment.hydration = (@nourishment.hydration + hydration_modifier).clamp(0, max_hydration)

          @nourishment.save!
        end

        def send_nourishment_message(calories_modifier, hydration_modifier)
          current_stage = {
            calories:  hunger_stage(calories),
            hydration: thirst_stage(hydration)
          }

          new_stage = {
            calories:  hunger_stage(calories  + calories_modifier),
            hydration: thirst_stage(hydration + hydration_modifier)
          }

          messages = []

          messages << hunger_stage_description(new_stage[:calories]) if current_stage[:calories] != new_stage[:calories]

          messages << thirst_stage_description(new_stage[:hydration]) if current_stage[:hydration] != new_stage[:hydration]

          return if messages.empty?

          messages = messages.join(" and ")

          @character_controller.tx("You are #{messages}.")
        end
      end
    end
  end
end
