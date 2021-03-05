require "mixins/slots/definition"

module ChatoMud
  module Actions
    class Title < BaseAction
      include Mixins::Slots::Definition

      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        speech = @params[:speech]

        target_item_controller = @character_controller.search_item_controller(target, :held)

        return unless check_target_present(target_item_controller, "You are not holding the '#{target[:word]}'.")

        return unless check_is_book(target_item_controller, "You cannot title #{target_item_controller.short_desc}.")

        return unless check_book_is_not_titled(target_item_controller.book_controller, "#{target_item_controller.short_desc} is already titled.")

        source_item_controller_slot = opposite_hand_slot[target_item_controller.slot]

        source_item_controller = @character_controller.inventory_controller.find_item_controller_by_slot(source_item_controller_slot)

        return unless check_target_present(source_item_controller, "You must be holding some means to title #{target_item_controller.short_desc} in your other hand.")

        return unless check_is_writing_implement(source_item_controller, "You cannot title anything with #{source_item_controller.short_desc}.")

        return unless check_writing_implement_bears_dipping_ink(source_item_controller.writing_implement_controller, "Use something else than #{source_item_controller.short_desc} for this purpose.")

        return unless check_writing_implement_is_charged(source_item_controller.writing_implement_controller, "You will need to dip #{source_item_controller.short_desc} somewhere first.")

        return unless check_length_is_within(speech, 1, 80, "The title must be between 1 and 80 characters long.")

        target_item_controller.book_controller.receive_title(@character_controller, source_item_controller.writing_implement_controller, speech)

        room_controller.emit_action_echo("title", { emitter: @character_controller, target: target_item_controller, source: source_item_controller })
      end
    end
  end
end
