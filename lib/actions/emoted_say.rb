module ChatoMud
  module Actions
    class EmotedSay < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        emote  = @params[:emote]
        speech = @params[:speech]

        room_controller.emit_action_echo("emoted_say", { emitter: @character_controller, emote: emote, speech: speech, type: :say })
      end
    end
  end
end
