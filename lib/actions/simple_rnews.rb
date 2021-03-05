module ChatoMud
  module Actions
    class SimpleRnews < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        index  = integer!(:index)

        item_controllers = @character_controller.room_controller.inventory_controller.find_board_controllers

        return unless check_count_is_positive(item_controllers, "There do not seem to be any news boards here.")

        item_controller = item_controllers[0]

        return unless check_board_index_is_within_bounds(item_controller.board_controller, index, "#{item_controller.short_desc} has no such index.")

        tx("\n#{item_controller.board_controller.show(index)}\n")
      end
    end
  end
end
