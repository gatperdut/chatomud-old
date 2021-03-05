module ChatoMud
  module Mixins
    module Characters
      module Combat
        module RangedDamageDealer
          def perform_ranged_attack(target_controller, missile_controller, line_of_sight, direction)
            ranged_offensive_capability = @character_controller.stats_controller.ranged_offensive_capability

            target_controller.combat_controller.receive_ranged_attack(character_controller, ranged_offensive_capability, missile_controller, line_of_sight, direction)
          end
        end
      end
    end
  end
end
