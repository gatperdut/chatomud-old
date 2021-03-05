require "mixins/slots/definition"

module ChatoMud
  module Actions
    class Wipe < BaseAction
      include Mixins::Slots::Definition

      def exec
        return unless can_perform?([:unconscious, :in_combat])

        target = @params[:target]

        target_item_controller = @character_controller.search_item_controller(target, :held)

        return unless check_target_present(target_item_controller, "You are not holding the '#{target[:word]}'.")

        if target_item_controller.is_book?
          tx("Writings in books and tomes cannot be wiped.")
          return
        end

        return unless check_is_writing(target_item_controller, "You cannot wipe #{target_item_controller.short_desc}.")

        return unless check_writing_is_not_blank(target_item_controller.writing_controller, "There is nothing written on #{target_item_controller.short_desc}.")

        return unless check_writing_is_wipeable(target_item_controller.writing_controller, "The #{target_item_controller.writing_controller.post_controller.ink_type_name} on #{target_item_controller.short_desc} cannot be wiped.")

        room_controller.emit_action_echo("wipe", { emitter: @character_controller, target: target_item_controller })

        target_item_controller.writing_controller.wipe
      end
    end
  end
end
