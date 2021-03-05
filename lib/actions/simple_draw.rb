module ChatoMud
  module Actions
    class SimpleDraw < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        return unless check_count_is_positive(@character_controller.inventory_controller.sheath_item_controllers(:any), "You are carrying no sheaths.")

        sheath_controllers = @character_controller.inventory_controller.sheath_item_controllers(:full)

        return unless check_count_is_positive(sheath_controllers, "You are carrying no weapons in your sheaths.")

        sheath_controller = sheath_controllers[0]

        target_controller = sheath_controller.inventory_controller.sheathed_weapon_controller

        return unless check_can_wield(target_controller)

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("draw", { emitter: @character_controller, target: target_controller, sheath: sheath_controller })

        @character_controller.inventory_controller.accept_item(target_controller, true)
        @character_controller.inventory_controller.wield(target_controller)
      end
    end
  end
end
