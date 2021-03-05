module ChatoMud
  module Actions
    class Exits < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        text = "You peer around"

        connections_text = @character_controller.room_controller.list_connections(@character_controller)

        if connections_text.blank?
          text << ", but there seem to be no available exits."
        else
          text << " ...\n#{connections_text}"
        end

        tx(text)
      end
    end
  end
end
