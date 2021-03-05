module ChatoMud
  module Mixins
    module Characters
      module Combat
        module MeleeDamageDealer
          def perform_melee_attacks(target_controller)
            melee_offensive_capabilities = @character_controller.stats_controller.melee_offensive_capabilities

            melee_offensive_capabilities.each do |melee_offensive_capability|
              target_controller.combat_controller.receive_melee_attack(character_controller, melee_offensive_capability)

              @character_controller.health_controller.consume_exhaustion(1)

              break if target_controller.health_controller.is_knocked_out?
            end

            handle_dead_opponent        if target_controller.health_controller.is_dead?
            handle_unconscious_opponent if target_controller.health_controller.is_unconscious?
          end
        end
      end
    end
  end
end
