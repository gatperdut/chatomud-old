require "mixins/characters/combat/roll_attack"
require "mixins/random/utils"

module ChatoMud
  module Mixins
    module Characters
      module Combat
        module RangedDamageTaker
          include Mixins::Characters::Combat::RollAttack
          include Mixins::Random::Utils

          def receive_ranged_attack(assailant_controller, ranged_offensive_capability, missile_controller, line_of_sight, direction)
            ranged_defensive_capability = stats_controller.ranged_defensive_capability

            body_part = self.class.all_body_parts.sample # TODO: Favour some parts over others.

            attack = roll_attack(ranged_offensive_capability, ranged_defensive_capability, body_part)

            echo_data = {
              target:    character_controller,
              attack:    attack,
              missile:   missile_controller,
              direction: direction,
              body_part: body_part
            }

            room_controller.emit_action_echo("ranged_attack", echo_data.merge(dest_room: :target))

            if room_controller != assailant_controller.room_controller
              assailant_controller.room_controller.emit_action_echo("ranged_attack", echo_data.merge(dest_room: :aimer))
            end

            if direction
              direction = direction.to_sym
              line_of_sight.pop
              line_of_sight.each do |connection|
                connection[0].emit_action_echo("missile_passing", { direction: direction, missile: missile_controller })
              end
            end

            room_controller.inventory_controller.accept_item(missile_controller, true) unless attack.connects

            health_controller.suffer_ranged_attack(attack, missile_controller, body_part) if attack.connects

            health_controller.check_liveness
          end
        end
      end
    end
  end
end
