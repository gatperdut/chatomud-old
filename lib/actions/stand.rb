module ChatoMud
  module Actions
    class Stand < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        if position_controller.is_standing?
          tx("You are already standing.")
          return
        end

        room_controller.emit_action_echo("stand", { emitter: @character_controller })
        position_controller.stand
      end
    end
  end
end
