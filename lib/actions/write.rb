require "mixins/slots/definition"

module ChatoMud
  module Actions
    class Write < BaseAction
      include Mixins::Slots::Definition

      def exec
        return unless can_perform?([:unconscious, :in_combat])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to write.")

        target = @params[:target]

        target_item_controller = @character_controller.search_item_controller(target, :held)

        return unless check_target_present(target_item_controller, "You are not holding the '#{target[:word]}'.")

        return unless check_is_readable_writable(target_item_controller, "You cannot write on #{target_item_controller.short_desc}.")

        if target_item_controller.is_book?
          return unless check_book_is_open(target_item_controller.book_controller, "You will need to open #{target_item_controller.short_desc} first. Or were you thinking of the 'title' command?")

          return unless check_book_has_pages(target_item_controller.book_controller, "#{target_item_controller.short_desc} has no pages left.")

          return unless check_book_page_is_blank(target_item_controller.book_controller, "This page in #{target_item_controller.short_desc} has been already written on.")
        end

        if target_item_controller.is_writing?
          return unless check_writing_is_blank(target_item_controller.writing_controller, "#{target_item_controller.short_desc} has been already written on.")
        end

        source_item_controller_slot = opposite_hand_slot[target_item_controller.slot]

        source_item_controller = @character_controller.inventory_controller.find_item_controller_by_slot(source_item_controller_slot)

        return unless check_target_present(source_item_controller, "You must be holding some means to write on #{target_item_controller.short_desc} in your other hand.")

        return unless check_is_writing_implement(source_item_controller, "You cannot write on anything with #{source_item_controller.short_desc}.")

        return unless check_writing_implement_is_charged(source_item_controller.writing_implement_controller, "You will need to dip #{source_item_controller.short_desc} somewhere first.")

        if target_item_controller.is_writing?
          if target_item_controller.writing_controller.is_wipeable?
            return unless check_writing_implement_bears_picking_ink(source_item_controller.writing_implement_controller, "You cannot write on #{target_item_controller.short_desc} with #{source_item_controller.writing_implement_controller.ink_type_name}.")
          end
          if target_item_controller.writing_controller.is_not_wipeable?
            return unless check_writing_implement_bears_dipping_ink(source_item_controller.writing_implement_controller, "You cannot write on #{target_item_controller.short_desc} with #{source_item_controller.writing_implement_controller.ink_type_name}.")
          end
        end

        if target_item_controller.is_book?
          return unless check_writing_implement_bears_dipping_ink(source_item_controller.writing_implement_controller, "You cannot write on #{target_item_controller.short_desc} with #{source_item_controller.writing_implement_controller.ink_type_name}.")
        end

        target_item_controller.writing_controller.write(@character_controller, source_item_controller.writing_implement_controller) if target_item_controller.is_writing?

        target_item_controller.book_controller.write(@character_controller, source_item_controller.writing_implement_controller) if target_item_controller.is_book?
      end
    end
  end
end
