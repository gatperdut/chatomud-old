module ChatoMud
  module Actions
    class News < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :room)

        return unless check_target_present(item_controller, "You cannot find the messages board '#{target[:word]}'.")

        return unless check_is_board(item_controller, "#{item_controller.short_desc} is not a news board.")

        return unless check_board_has_content(item_controller.board_controller, "#{item_controller.short_desc} bears no news yet.")

        tx("\n#{item_controller.board_controller.list(1)}")
      end
    end
  end
end
