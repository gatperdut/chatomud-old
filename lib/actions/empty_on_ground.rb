module ChatoMud
  module Actions
    class EmptyOnGround < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :carried)

        return unless check_target_present(item_controller, "You are not holding the '#{target[:word]}'.")

        return unless check_is_container(item_controller, "#{item_controller.short_desc} is not a container.")

        if check_is_closable(item_controller.inventory_controller)
          return unless check_container_or_door_is_open(item_controller.inventory_controller.lid_controller, "#{item_controller.short_desc} is closed.")
        end

        return unless check_has_content(item_controller.inventory_controller, "#{item_controller.short_desc} is already empty.")

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("empty_on_ground", { emitter: @character_controller, target: item_controller })
        item_controller.inventory_controller.dump_items_into(room_controller)
      end
    end
  end
end
