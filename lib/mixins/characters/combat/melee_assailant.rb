module ChatoMud
  module Mixins
    module Characters
      module Combat
        module MeleeAssailant
          def start_switch_thread
            @switch_thread = Thread.new(self) do |combat_controller|
              sleep 5
            end
          end

          def start_combat_thread
            @combat_thread = Thread.new(self) do |combat_controller|
              sleep rand(1..9)
              loop do
                combat_controller.perform_melee_attacks(combat_controller.target) if combat_controller.target
                sleep 9
              end
            end
          end

          def is_attacking?
            !!@target
          end

          def is_switching?
            @switch_thread.present? && @switch_thread.alive?
          end

          def target_is?(opponent_controller)
            @target == opponent_controller
          end

          def list_target
            @target.short_desc
          end

          def handle_become_pacifist
            stop_combat(true, true) if is_attacking?
          end

          def handle_become_belligerent
            fight(@assailants[0], false) if is_being_attacked?
          end

          def fight(opponent_controller, is_initiator)
            start_switch_thread
            if is_initiator
              if is_attacking?
                switch_opponent(opponent_controller)
              else
                pick_opponent(opponent_controller)
              end
            else
              handle_fight_back(opponent_controller)
            end
          end

          def stop_combat(echo, stop_thread)
            room_controller.emit_action_echo("stop_combat", { emitter: @character_controller, target: @target }) if echo
            @target&.combat_controller&.remove_assailant(@character_controller)
            @target = nil
            @character_controller.aasm_controller.aasm_handle.stop_attacking if @character_controller.is_npc? && @character_controller.aasm_controller.aasm_handle.attacking?
            combat_thread_bye if stop_thread
          end

          def combat_thread_bye
            @combat_thread.terminate if @combat_thread.present? && @combat_thread.alive?
          end

          def handle_gone_opponent
            handle_target_gone
          end

          def handle_fled_opponent
            handle_target_gone
          end

          def handle_dead_opponent
            handle_target_gone
          end

          def handle_unconscious_opponent
            # TODO: Did we use hit (stop), or kill (continue)?
            handle_target_gone
          end

          private

          def handle_target_gone
            if is_being_attacked?
              switch_opponent(@assailants[0])
            elsif is_fleeing?
              stop_fleeing_knocked_out_opponent
              stop_combat(false, true)
            else
              stop_combat(false, true)
            end
          end

          def switch_opponent(opponent_controller)
            stop_combat(false, false)
            room_controller.emit_action_echo("switch_combat", { emitter: @character_controller, new_target: opponent_controller, old_target: @target })
            @target&.combat_controller&.remove_assailant(@character_controller)
            target!(opponent_controller)
            opponent_controller.combat_controller.handle_fight_back(@character_controller)
            # start_combat_thread
          end

          def pick_opponent(opponent_controller)
            room_controller.emit_action_echo("start_combat", { emitter: @character_controller, target: opponent_controller })
            target!(opponent_controller)
            opponent_controller.combat_controller.handle_fight_back(@character_controller)
            start_combat_thread
          end

          def target!(opponent_controller)
            @target = opponent_controller
          end
        end
      end
    end
  end
end
