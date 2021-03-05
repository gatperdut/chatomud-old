module ChatoMud
  module Actions
    class Health < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@character_controller.list_wounds(:personal))
      end
    end
  end
end
