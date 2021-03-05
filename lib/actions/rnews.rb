module ChatoMud
  module Actions
    class Rnews < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        index  = integer!(:index)

        item_controller = @character_controller.search_item_controller(target, :room)

        return unless check_target_present(item_controller, "You cannot find the messages board '#{target[:word]}'.")

        return unless check_is_board(item_controller, "#{item_controller.short_desc} is not a news board.")

        return unless check_board_index_is_within_bounds(item_controller.board_controller, index, "#{item_controller.short_desc} has no such index.")

        tx("\n#{item_controller.board_controller.show(index)}\n")
      end
    end
  end
end
