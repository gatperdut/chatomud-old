require "mixins/armor/utils"

module ChatoMud
  module Controllers
    module Characters
      class EncumbranceController
        include Mixins::Armor::Utils

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
        end

        def encumbrance_level
          @character_controller.inventory_controller.dead_weight / weight_allowance
        end

        def encumbrance_penalty
          penalty =  dead_weight_penalty +
                     armor_general_penalty -
                     3 * @character_controller.stats_controller.attribute_bonus(:str)

          [0, penalty].max
        end

        def armor_ranged_penalty
          result = 0

          @character_controller.inventory_controller.armor_item_controllers.each do |item_controller|
            result += armor_ranged_penalty_for(item_controller)
          end

          result.round
        end

        private

        def dead_weight_penalty
          8 * encumbrance_level
        end

        def weight_allowance
          (@character_controller.physical_attr_controller.weight * 1000 / 10.0).round
        end

        def armor_general_penalty
          protection = @server.protection_referrer.find(@character_controller.inventory_controller.armor_penalty_level)

          [protection.max_penalty - @character_controller.stats_controller.skill_modifier(:armor_use) / 2, protection.min_penalty].max
        end

        def armor_ranged_penalty_for(item_controller)
          protection = @server.protection_referrer.find(item_controller.armor_stat_controller.penalty_level)

          ranged_attack_impediment_factor = ranged_attack_impediment_factor_for(item_controller.armor_stat_controller.ranged_attack_impediment)

          (protection.max_penalty / 4.0 * ranged_attack_impediment_factor).round
        end
      end
    end
  end
end
