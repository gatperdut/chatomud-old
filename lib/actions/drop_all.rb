module ChatoMud
  module Actions
    class DropAll < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        item_controllers = @character_controller.inventory_controller.carried_item_controllers

        return unless check_count_is_positive(item_controllers, "You aren't holding anything.")

        interrupt_ranged_weapon_handling

        item_controllers = @character_controller.inventory_controller.carried_item_controllers

        @character_controller.inventory_controller.drop_carried_items

        room_controller.emit_action_echo("drop_all", { emitter: @character_controller, items: item_controllers })
      end
    end
  end
end
