module ChatoMud
  module Actions
    class DipDipping < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        source = @params[:source]

        target_item_controller = @character_controller.search_item_controller(target, :held)

        return unless check_target_present(target_item_controller, "You are not holding the '#{target[:word]}'.")

        return unless check_is_writing_implement(target_item_controller, "#{target_item_controller.short_desc} is nothing you could dip.")

        return unless check_writing_implement_is_not_single_use(target_item_controller.writing_implement_controller, "#{target_item_controller.short_desc} does not work like that.")

        return unless check_writing_implement_is_not_charged(target_item_controller.writing_implement_controller, "#{target_item_controller.short_desc} already bears some #{target_item_controller.writing_implement_controller.ink_type_name}.")

        source_item_controller = @character_controller.search_item_controller(source, :held_or_room)

        return unless check_target_present(source_item_controller, "You cannot find the '#{source[:word]}'.")

        return unless check_is_ink_source(source_item_controller, "#{source_item_controller.short_desc} is nothing you could dip into.")

        return unless check_ink_source_is_dipping(source_item_controller.ink_source_controller, "#{source_item_controller.short_desc} does not work that way.")

        return unless check_ink_source_has_charges_left(source_item_controller.ink_source_controller, "#{source_item_controller.short_desc} seems to be empty.")

        source_item_controller.ink_source_controller.charge(target_item_controller)

        room_controller.emit_action_echo("dip_dipping", { emitter: @character_controller, target: target_item_controller, source: source_item_controller })
      end
    end
  end
end
