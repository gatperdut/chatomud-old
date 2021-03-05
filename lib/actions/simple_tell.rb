module ChatoMud
  module Actions
    class SimpleTell < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        speech = @params[:speech]

        target_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(target_controller, "Who do you want to tell that to?")

        room_controller.emit_action_echo("simple_tell", { emitter: @character_controller, target: target_controller, speech: speech })
      end
    end
  end
end
