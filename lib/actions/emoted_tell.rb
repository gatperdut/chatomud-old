module ChatoMud
  module Actions
    class EmotedTell < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        emote  = @params[:emote]
        speech = @params[:speech]

        target_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(target_controller, "Who do you want to tell that to?")

        room_controller.emit_action_echo("emoted_tell", { emitter: @character_controller, target: target_controller, emote: emote, speech: speech })
      end
    end
  end
end
