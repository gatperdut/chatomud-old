module ChatoMud
  module Actions
    class DirectedSheathe < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        sheath = @params[:sheath]

        target_controller = @character_controller.search_item_controller(target, :carried)

        return unless check_target_present(target_controller, "You do not see that '#{target[:word]}'.")

        return unless check_is_melee_weapon(target_controller, "You cannot sheathe #{target_controller.short_desc}.")

        sheath_controller = @character_controller.search_item_controller(sheath, :sheath)

        return unless check_target_present(sheath_controller, "You cannot find the '#{sheath[:word]}'.")

        return unless check_has_no_content(sheath_controller.inventory_controller, "#{sheath_controller.short_desc} is already bearing #{sheath_controller.inventory_controller.list_inventory(:short_desc)}.")

        interrupt_ranged_weapon_handling

        sheath_controller.inventory_controller.accept_item(target_controller, true)
        room_controller.emit_action_echo("sheathe", { emitter: @character_controller, target: target_controller, sheath: sheath_controller })
      end
    end
  end
end
