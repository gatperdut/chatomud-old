require "mixins/characters/status/markers/visibility"
require "mixins/characters/status/markers/aiming"
require "mixins/characters/status/markers/target"
require "mixins/characters/status/markers/fleeing"
require "mixins/characters/encumbrance/utils"

module ChatoMud
  module Mixins
    module Characters
      module Status
        module Utils
          include Mixins::Characters::Status::Markers::Visibility
          include Mixins::Characters::Status::Markers::Aiming
          include Mixins::Characters::Status::Markers::Target
          include Mixins::Characters::Status::Markers::Fleeing
          include Mixins::Characters::Encumbrance::Utils

          def main_status
            text = "\n#{name.green}, #{short_desc}\n\n"

            text << "#{@stats_controller.list_attributes}\n\n"

            text << "You are #{@position_controller.position_description}.\n"
            text << "When in combat, your stance is #{@choice_controller.stance_colorized}.\n"
            text << "During editing, you #{@choice_controller.editor_echoes_colorized} receive echoes of your input.\n"
            text << "You are #{@physical_attr_controller.height} centimeters tall and weight #{physical_attr_controller.weight} kilograms.\n"
            text << "You are currently speaking #{@choice_controller.language_formatted} and set to write in #{@choice_controller.script_formatted}.\n"
            text << "You are #{@nourishment_controller.hunger_stage_description} (#{@nourishment_controller.calories} / #{@nourishment_controller.max_calories}) and #{@nourishment_controller.thirst_stage_description} (#{@nourishment_controller.hydration} / #{@nourishment_controller.max_hydration}).\n"
            text << "You are currently carrying #{@inventory_controller.borne_weight} grams, #{@inventory_controller.dead_weight} of which is dead weight.\n"
            text << "Your are #{encumbrance_description(@encumbrance_controller.encumbrance_level)}.\n"
            text << "You #{@choice_controller.pace_colorized} when you travel.\n"
            text << "You are attacking #{@combat_controller.list_target}\n" if combat_controller.is_attacking?
            text << "You are being attacked by #{@combat_controller.list_assailants}\n" if combat_controller.is_being_attacked?
            text << "You are being aimed at by #{@combat_controller.list_aimers}\n" if combat_controller.is_being_aimed_at?

            text
          end

          def quick_status
            qs = "#{visibility_marker}<#{health_bar}##{exhaustion_bar}>#{@health_controller.hits}/#{@health_controller.max_hits}#{fleeing_marker}#{aim_marker}#{load_marker}#{holding_load_marker}#{target_marker}"

            qs
          end

          def health_bar
            craft_bar(@health_controller.hits, @health_controller.max_hits, "*")
          end

          def exhaustion_bar
            craft_bar(@health_controller.exhaustion, @health_controller.max_exhaustion, "|")
          end

          private

          def craft_bar(current, max, char)
            mn = marks_number(current, max)

            result = ""
            6.step(1, -1) do |n|
              if n <= mn
                result << char.send("#{mark_color(n)}")
              else
                result << " "
              end
            end

            result
          end

          def mark_color(index)
            return "red" if index <= 2
            return "yellow" if index <= 4

            "green"
          end

          def marks_number(current, max)
            percentage = current / max.to_f

            return 0 if percentage <= 0.0

            case percentage
              when 0.01..0.20
                1
              when 0.20..0.40
                2
              when 0.40..0.60
                3
              when 0.60..0.80
                4
              when 0.81..0.99
                5
              when 1.00
                6
              else
                raise "marks number over 100%"
            end
          end
        end
      end
    end
  end
end
