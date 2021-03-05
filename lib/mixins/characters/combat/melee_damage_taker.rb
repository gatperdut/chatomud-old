require "mixins/characters/combat/roll_attack"
require "mixins/random/utils"

module ChatoMud
  module Mixins
    module Characters
      module Combat
        module MeleeDamageTaker
          include Mixins::Characters::Combat::RollAttack
          include Mixins::Random::Utils

          def receive_melee_attack(assailant_controller, melee_offensive_capability)
            melee_defensive_capability = stats_controller.melee_defensive_capability(assailant_controller)

            body_part = self.class.all_body_parts.sample # TODO: Favour some parts over others.

            attack = roll_attack(melee_offensive_capability, melee_defensive_capability, body_part)

            echo_params = {
              assailant: assailant_controller,
              target:    character_controller,
              weapon:    melee_offensive_capability[:controller],
              attack:    attack,
              body_part: body_part
            }

            health_controller.suffer_melee_attack(attack, body_part) if attack.connects

            room_controller.emit_action_echo("melee_attack", echo_params)

            health_controller.check_liveness
          end
        end
      end
    end
  end
end
