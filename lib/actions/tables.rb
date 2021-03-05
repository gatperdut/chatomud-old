module ChatoMud
  module Actions
    class Tables < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(room_controller.list_accommodations(@character_controller))
      end
    end
  end
end
