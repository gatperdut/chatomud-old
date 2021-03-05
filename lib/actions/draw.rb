module ChatoMud
  module Actions
    class Draw < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        return unless check_count_is_positive(@character_controller.inventory_controller.sheath_item_controllers(:any), "You are carrying no sheaths.")

        target_controller = @character_controller.search_item_controller(target, :sheathed)

        return unless check_target_present(target_controller, "You are not carrying the '#{target[:word]}' in any of your sheaths.")

        return unless check_can_wield(target_controller)

        interrupt_ranged_weapon_handling

        sheath_controller = target_controller.containing_inventory_controller.owner_controller

        room_controller.emit_action_echo("draw", { emitter: @character_controller, target: target_controller, sheath: sheath_controller })

        @character_controller.inventory_controller.accept_item(target_controller, true)
        @character_controller.inventory_controller.wield(target_controller)
      end
    end
  end
end
