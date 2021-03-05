module ChatoMud
  module Actions
    class Score < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@character_controller.main_status)
      end
    end
  end
end
