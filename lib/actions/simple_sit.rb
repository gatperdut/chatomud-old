module ChatoMud
  module Actions
    class SimpleSit < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        if position_controller.is_sitting?
          tx("You are already sitting.")
          return
        end

        interrupt_ranged_weapon_handling

        if position_controller.is_standing?
          room_controller.emit_action_echo("simple_sit", { emitter: @character_controller, from: :standing })
          position_controller.sit
          return
        end

        if position_controller.is_resting?
          room_controller.emit_action_echo("simple_sit", { emitter: @character_controller, from: :resting })
          position_controller.sit
          return
        end

        raise "sitting with unknown position"
      end
    end
  end
end
