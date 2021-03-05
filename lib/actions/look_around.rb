module ChatoMud
  module Actions
    class LookAround < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@character_controller.show_room)
      end
    end
  end
end
