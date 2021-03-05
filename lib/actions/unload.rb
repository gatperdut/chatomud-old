module ChatoMud
  module Actions
    class Unload < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        interrupt_transient_ranged_weapon_handling

        wielded_ranged_weapon_controller = @character_controller.inventory_controller.ranged_weapon_controllers(:held_or_wielded, :indifferent)[0]

        return unless check_target_present(wielded_ranged_weapon_controller, "You have no weapon to unload.")

        return unless check_is_loaded(wielded_ranged_weapon_controller, "#{wielded_ranged_weapon_controller.short_desc} is not loaded.")

        missile_controller = wielded_ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.loaded_missile_controller

        return unless check_can_load_or_unload(wielded_ranged_weapon_controller, missile_controller, "You will a need free hand to unload #{wielded_ranged_weapon_controller.short_desc}.")

        quiver_controllers = @character_controller.inventory_controller.quiver_controllers(:worn)

        unless check_count_is_positive(quiver_controllers)
          if wielded_ranged_weapon_controller.is_in_slot?(:w2hands)
            wielded_ranged_weapon_controller.set_slot(:wlhand, false)

            @character_controller.inventory_controller.accept_item(missile_controller, true)

            wielded_ranged_weapon_controller.set_slot(:wlhand, true)
          else
            @character_controller.inventory_controller.accept_item(missile_controller, true)
          end

          room_controller.emit_action_echo("unload", { emitter: @character_controller, ranged_weapon: wielded_ranged_weapon_controller, missile: missile_controller, destination: :hand })

          return
        end

        quiver_controller = quiver_controllers[0]

        quiver_controller.inventory_controller.accept_item(missile_controller, true)

        wielded_ranged_weapon_controller.set_slot(:wlhand, true)

        room_controller.emit_action_echo("unload", { emitter: @character_controller, ranged_weapon: wielded_ranged_weapon_controller, missile: missile_controller, destination: quiver_controller })
      end
    end
  end
end
