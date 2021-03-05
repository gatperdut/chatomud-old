module ChatoMud
  module Actions
    class SimpleSay < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        speech = @params[:speech]

        room_controller.emit_action_echo("simple_say", { emitter: @character_controller, speech: speech, type: :say })
      end
    end
  end
end
