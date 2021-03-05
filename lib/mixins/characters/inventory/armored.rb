require "mixins/armor/utils"

module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module Armored
          include Mixins::Armor::Utils

          def armor_controllers_for(body_part)
            result = []
            armor_item_controllers.each do |armor_item_controller|
              result << armor_item_controller if armor_item_controller.armor_stat_controller.body_parts.map(&:to_sym).include?(body_part.to_sym)
            end

            result.sort_by do |armor_controller|
              -armor_controller.armor_stat_controller.protection_level
            end

            result
          end

          def armor_penalty_level
            result = 0.0
            armor_item_controllers.each do |armor_item_controller|
              maneuver_impediment_factor = maneuver_impediment_factor_for(armor_item_controller.armor_stat_controller.maneuver_impediment)

              result += armor_item_controller.armor_stat_controller.penalty_level * maneuver_impediment_factor
            end

            result.round.clamp(1, 20)
          end

          def armor_for(body_part)
            result = {
              controllers: [],
              protection_level: 1,
              modifiers: {
                roll:     0,
                critical: 0
              }
            }

            result[:item_controllers] = armor_controllers_for(body_part)

            ordered_armor_controllers = armor_controllers_for(body_part)

            first_armor_controller = ordered_armor_controllers.shift

            return result if first_armor_controller.nil?

            result[:protection_level] = first_armor_controller.armor_stat_controller.protection_level
            result[:roll_mod]         = first_armor_controller.armor_stat_controller.roll_mod
            result[:critical_mod]     = first_armor_controller.armor_stat_controller.critical_mod

            ordered_armor_controllers.each do |armor_controller|
              result[:protection_level] += 1
              result[:roll_mod]         += armor_controller.armor_stat_controller.roll_mod
              result[:critical_mod]     += armor_controller.armor_stat_controller.critical_mod
            end

            result[:protection_level] = result[:protection_level].clamp(1, 20)

            result
          end

          def list_armor
            text = "Your armor:\n"
            self.class.all_body_parts.each do |body_part|
              text << "#{body_part}: "
              result = armor_for(body_part)
              if result[:item_controllers].empty?
                text << "<none>\n"
              else
                text << result[:item_controllers].map(&:short_desc).join("/")
                text << " ( Lvl #{result[:protection_level]}, RollMod #{result[:roll_mod]}, CritMod #{result[:critical_mod]})"
                text << "\n"
              end
            end

            text
          end
        end
      end
    end
  end
end
