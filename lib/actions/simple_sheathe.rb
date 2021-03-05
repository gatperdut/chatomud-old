module ChatoMud
  module Actions
    class SimpleSheathe < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        target_controller = @character_controller.search_item_controller(target, :carried)

        return unless check_target_present(target_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_melee_weapon(target_controller, "You cannot sheathe #{target_controller.short_desc}.")

        sheath_controllers = @character_controller.inventory_controller.sheath_item_controllers(:any)

        return unless check_count_is_positive(sheath_controllers, "You are carrying no sheaths.")

        sheath_controllers = sheath_controllers.reject do |sheath_controller|
          sheath_controller.inventory_controller.has_content?
        end

        return unless check_count_is_positive(sheath_controllers, "You are carrying no free sheaths.")

        interrupt_ranged_weapon_handling

        sheath_controller = sheath_controllers[0]

        sheath_controller.inventory_controller.accept_item(target_controller, true)
        room_controller.emit_action_echo("sheathe", { emitter: @character_controller, target: target_controller, sheath: sheath_controller })
      end
    end
  end
end
