module ChatoMud
  module Actions
    class SimpleEmote < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        emote = @params[:emote]

        room_controller.emit_action_echo("simple_emote", { emitter: @character_controller, emote: emote })
      end
    end
  end
end
