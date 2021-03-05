require "mixins/characters/choices/paces/utils"
require "mixins/characters/physical_attrs/height/utils"

module ChatoMud
  module Mixins
    module Characters
      module Walking
        module Pacer
          include Mixins::Characters::Choices::Paces::Utils
          include Mixins::Characters::PhysicalAttrs::Height::Utils
          include Mixins::Characters::Choices::Paces::Utils

          def travel_time
            time  = 3.0

            time *= @character_controller.stats_controller.agility_travel_time_multiplier

            time *= pace_travel_time_multiplier(@character_controller.choice_controller.pace)

            time *= height_travel_time_multiplier(@character_controller.physical_attr_controller.height)

            time *= @character_controller.room_controller.roughness_multiplier

            time
          end

          def travel_exhaustion
            base  = pace_travel_exhaustion_base(@character_controller.choice_controller.pace)

            base *= hits_travel_exhaustion_multiplier(@character_controller.health_controller.hits_percentage)

            base * @character_controller.room_controller.roughness_multiplier
          end

          def has_enough_exhaustion?
            @character_controller.health_controller.can_consume_exhaustion?(travel_exhaustion)
          end

          def consume_exhaustion
            @character_controller.health_controller.consume_exhaustion(travel_exhaustion)
          end

          def check_allowed_pace
            valid_paces = allowed_paces(@character_controller.encumbrance_controller.encumbrance_penalty)

            return if valid_paces.include?(@character_controller.choice_controller.pace.to_sym)

            new_pace = valid_paces.last

            @character_controller.tx("Your movement is too restricted to keep that pace, from now on you will #{new_pace}.")

            @character_controller.choice_controller.set_pace(new_pace)
          end
        end
      end
    end
  end
end
