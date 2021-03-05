module ChatoMud
  module Actions
    class Flip < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        page   = integer!(:page)

        item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_book(item_controller, "#{item_controller.short_desc} is nothing you could flip the pages of.")

        return unless check_book_is_open(item_controller.book_controller, "Open #{item_controller.short_desc} first.")

        return unless check_book_has_pages(item_controller.book_controller, "#{item_controller.short_desc} has no pages, unfortunately.")

        return unless check_book_page_is_within_bounds(item_controller.book_controller, page, "No such page in #{item_controller.short_desc}.")

        item_controller.book_controller.flip(page - 1)

        room_controller.emit_action_echo("flip", { emitter: @character_controller, target: item_controller })
      end
    end
  end
end
