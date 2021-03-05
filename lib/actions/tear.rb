module ChatoMud
  module Actions
    class Tear < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        @item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(@item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_readable_writable(@item_controller, "#{@item_controller.short_desc} is nothing you could tear.")

        tear_book    if @item_controller.is_book?

        tear_writing if @item_controller.is_writing?
      end

      def tear_book
        return unless check_book_is_open(@item_controller.book_controller, "Open #{@item_controller.short_desc} first.")

        return unless check_book_has_pages(@item_controller.book_controller, "#{@item_controller.short_desc} has no pages, unfortunately.")

        return unless check_character_can_hold(@character_controller, nil, "You will need a free hand to do that.")

        room_controller.emit_action_echo("tear_book", { emitter: @character_controller, target: @item_controller })
        @item_controller.book_controller.tear_page(@character_controller)
      end

      def tear_writing
        room_controller.emit_action_echo("tear_writing", { emitter: @character_controller, target: @item_controller })
        @item_controller.junk(true)
      end
    end
  end
end
