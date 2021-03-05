module ChatoMud
  module Actions
    class Read < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_readable_writable(item_controller, "#{item_controller.short_desc} is nothing you could read.")

        tx("\n#{item_controller.book_controller.read(@character_controller)}")    if item_controller.is_book?

        tx("\n#{item_controller.writing_controller.read(@character_controller)}") if item_controller.is_writing?
      end
    end
  end
end
