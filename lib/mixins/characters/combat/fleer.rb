require "mixins/random/utils"

module ChatoMud
  module Mixins
    module Characters
      module Combat
        module Fleer
          include Mixins::Random::Utils

          def start_flee_thread
            @flee_thread = Thread.new(self, @flee_direction) do |combat_controller, flee_direction|
              success = false
              until success
                sleep 10
                success = attempt_flee
              end
            end
          end

          def flee(flee_direction, echo)
            room_controller.emit_action_echo("flee_start", { emitter: @character_controller }) if echo
            @flee_direction = flee_direction
            start_flee_thread
          end

          def group_flee(flee_direction)
            followers = @character_controller.group_controller.followers
            room_controller.emit_action_echo("group_flee_start", { emitter: @character_controller, followers: followers, direction: flee_direction })
            @character_controller.group_controller.group_members.each do |group_member|
              if group_member.can_walk?
                group_member.combat_controller.stop_fleeing(false)
                group_member.combat_controller.flee(flee_direction, false)
              end
            end
          end

          def is_fleeing?
            @flee_thread.present? && @flee_thread.alive?
          end

          def stop_fleeing(echo)
            room_controller.emit_action_echo("flee_stop", { emitter: @character_controller, reason: :requested }) if echo
            flee_thread_bye
          end

          def stop_fleeing_knocked_out_opponent
            room_controller.emit_action_echo("flee_stop", { emitter: @character_controller, reason: :unnecessary })
            flee_thread_bye
          end

          def flee_thread_bye
            @flee_thread.terminate if is_fleeing?
          end

          def attempt_flee
            roll = d100(:closed)

            outcome = roll < 51 ? :failure : :success

            send("flee_result_#{outcome}")
          end

          private

          def flee_result_failure
            room_controller.emit_action_echo("flee_outcome", { emitter: @character_controller, outcome: :failure })
            false
          end

          def flee_result_success
            if @character_controller.position_controller.is_sitting_or_resting?
              @character_controller.tx("Prone on the ground, you are unable to flee! You will need to try again.")
              return false
            end
            room_controller.emit_action_echo("flee_outcome", { emitter: @character_controller, outcome: :success })
            handle_flee_success
            true
          end
        end
      end
    end
  end
end
