module ChatoMud
  module Actions
    class SimpleNews < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        item_controllers = @character_controller.room_controller.inventory_controller.find_board_controllers

        return unless check_count_is_positive(item_controllers, "There do not seem to be any news boards here.")

        item_controller = item_controllers[0]

        return unless check_board_has_content(item_controller.board_controller, "#{item_controller.short_desc} bears no news yet.")

        tx("\n#{item_controller.board_controller.list(1)}")
      end
    end
  end
end
