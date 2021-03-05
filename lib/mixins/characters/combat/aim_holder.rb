module ChatoMud
  module Mixins
    module Characters
      module Combat
        module AimHolder
          def update_aim(reason, data)
            send("update_aim_#{reason}", data)
          end

          def update_aim_fled(data)
            update_aim_moved(data)
          end

          def update_aim_moved(data)
            if (@target_info[:distance]).zero?
              @target_info[:direction] = data[:direction]
            end

            if data[:direction] == @target_info[:direction].to_sym
              update_aim_moved_same_direction
            elsif data[:direction] == opposite(@target_info[:direction].to_sym)
              update_aim_moved_opposite_direction
            else
              done_aiming
              @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :moved, data: data })
            end
          end

          def update_aim_moved_same_direction
            @target_info[:distance] += 1
            if @target_info[:distance] <= 3
              @character_controller.tx("You hold your aim as your quarry moves further away ...")
            else
              done_aiming
              @character_controller.tx("You cease aiming, your quarry has moved too far away.")
            end
          end

          def update_aim_moved_opposite_direction
            @target_info[:distance] -= 1
            @character_controller.tx("You hold your aim as your quarry moves closer ...")
          end

          def update_aim_dead(data)
            done_aiming
            @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :dead, data: data })
          end

          def update_aim_unconscious(data)
            done_aiming
            @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :unconscious, data: data })
          end

          def update_aim_quit(data)
            @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :quit, data: data })
          end

          def update_aim_gone(data)
            @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :gone, data: data })
          end
        end
      end
    end
  end
end
