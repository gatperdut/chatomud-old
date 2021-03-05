module ChatoMud
  module Actions
    class Inventory < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@character_controller.list_inventory(:personal))
      end
    end
  end
end
