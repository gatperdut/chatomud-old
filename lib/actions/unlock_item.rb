module ChatoMud
  module Actions
    class UnlockItem < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        ground = bool!(:ground)

        item_controller = @character_controller.search_item_or_furniture_controller(target, ground)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_closable(item_controller.inventory_controller, "You cannot unlock #{item_controller.short_desc}.")

        return unless check_is_lockable(item_controller.inventory_controller.lid_controller, "#{item_controller.short_desc} has no lock.")

        return unless check_is_locked(item_controller.inventory_controller.lid_controller.lock_controller, "#{item_controller.short_desc} is already unlocked.")

        lockers = @character_controller.inventory_controller.lockers_for(item_controller.inventory_controller.lid_controller.lock_controller)

        return unless check_count_is_positive(lockers, "You are not holding anything capable of unlocking #{item_controller.short_desc}.")

        interrupt_ranged_weapon_handling

        item_controller.inventory_controller.lid_controller.lock_controller.unlock
        room_controller.emit_action_echo("unlock_item", { emitter: @character_controller, target: item_controller, with: lockers[0] })
      end
    end
  end
end
