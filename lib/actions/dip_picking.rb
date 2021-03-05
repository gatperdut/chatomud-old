module ChatoMud
  module Actions
    class DipPicking < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_ink_source(item_controller, "#{item_controller.short_desc} is nothing you could dip into.")

        return unless check_ink_source_is_picking(item_controller.ink_source_controller, "#{item_controller.short_desc} does not work that way. You need to dip something into it.")

        return unless check_ink_source_has_charges_left(item_controller.ink_source_controller, "#{item_controller.short_desc} seems to be empty.")

        return unless check_character_can_hold(@character_controller, nil, "You will need a free hand to do that.")

        spawned_item_controller = item_controller.ink_source_controller.take_one(@character_controller)

        room_controller.emit_action_echo("dip_picking", { emitter: @character_controller, target: item_controller, spawned: spawned_item_controller })
      end
    end
  end
end
