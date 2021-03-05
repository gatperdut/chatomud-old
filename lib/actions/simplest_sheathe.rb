module ChatoMud
  module Actions
    class SimplestSheathe < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        wielded_melee_weapons_controllers = @character_controller.inventory_controller.melee_weapon_controllers(:wielded)
        return unless check_count_is_positive(wielded_melee_weapons_controllers, "You are holding no melee weapons.")

        wielded_melee_weapon_controller = wielded_melee_weapons_controllers[0]

        sheath_controllers = @character_controller.inventory_controller.sheath_item_controllers(:any)

        return unless check_count_is_positive(sheath_controllers, "You are carrying no sheaths.")

        sheath_controllers = sheath_controllers.reject do |sheath_controller|
          sheath_controller.inventory_controller.has_content?
        end

        return unless check_count_is_positive(sheath_controllers, "You have no available sheaths.")

        interrupt_ranged_weapon_handling

        sheath_controller = sheath_controllers[0]

        sheath_controller.inventory_controller.accept_item(wielded_melee_weapon_controller, true)
        room_controller.emit_action_echo("sheathe", { emitter: @character_controller, target: wielded_melee_weapon_controller, sheath: sheath_controller })
      end
    end
  end
end
