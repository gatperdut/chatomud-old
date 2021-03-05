module ChatoMud
  module Actions
    class Load < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :in_combat])

        return unless check_is_not_loading(@character_controller, "You are already trying to load your weapon.")

        ranged_weapon_controllers = @character_controller.inventory_controller.ranged_weapon_controllers(:held_or_wielded, :indifferent)

        return unless check_count_is_positive(ranged_weapon_controllers, "You must be holding a single ranged weapon.")

        @wielded_ranged_weapon_controller = ranged_weapon_controllers[0]

        return unless check_is_wielded(@wielded_ranged_weapon_controller, "You will need to wield #{@wielded_ranged_weapon_controller.short_desc} first.")

        return unless check_is_not_loaded(@wielded_ranged_weapon_controller, "#{@wielded_ranged_weapon_controller.short_desc} is already loaded.")

        appropriate_missile_type = @wielded_ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.missile_type

        held_missile_controllers = @character_controller.inventory_controller.missile_controllers(:held, appropriate_missile_type)

        if check_count_is_positive(held_missile_controllers)
          held_missile_controller = held_missile_controllers[0]

          return unless check_missile_type_is(held_missile_controller, appropriate_missile_type, "You cannot load #{held_missile_controller.short_desc} in that weapon.")

          return unless check_has_amount_of(held_missile_controller.stack_controller, 1, "You must be carrying a single one of #{held_missile_controller.short_desc}.")

          do_load(held_missile_controller, :from_hand)
          return
        end

        return unless check_count_is_positive(@character_controller.inventory_controller.quiver_controllers(:worn), "You are carrying no quivers.")

        missile_controllers = @character_controller.inventory_controller.missile_controllers(:stowed, appropriate_missile_type)

        return unless check_count_is_positive(missile_controllers, "Your quivers contain no ammunition for #{@wielded_ranged_weapon_controller.short_desc}.")

        missile_controller = missile_controllers[0]

        return unless check_can_load_or_unload(@wielded_ranged_weapon_controller, missile_controller, "You will a need free hand to load #{@wielded_ranged_weapon_controller.short_desc}.")

        do_load(missile_controller, :from_quiver)
      end

      def do_load(missile_controller, from)
        @character_controller.load_controller.start_load_thread(missile_controller, from)
        room_controller.emit_action_echo("load", { emitter: @character_controller, missile: missile_controller, from: from })
      end
    end
  end
end
