module ChatoMud
  module Actions
    class SimpleShout < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        speech = @params[:speech]

        room_controller.emit_action_echo("simple_say", { emitter: @character_controller, speech: speech, type: :shout })

        room_controller.connections.each do |direction, connection|
          connecting_room_controller = connection[0]
          connecting_room_controller.emit_action_echo("hear_shout", { emitter: @character_controller, speech: speech, direction: direction })
        end
      end
    end
  end
end
