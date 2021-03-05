module ChatoMud
  module Actions
    class AimSimple < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :in_combat])

        unless check_is_not_aiming(@character_controller, nil)
          interrupt_aiming
        end

        target = @params[:target]

        ranged_weapon_controllers = @character_controller.inventory_controller.ranged_weapon_controllers(:held_or_wielded, :indifferent)

        return unless check_count_is_positive(ranged_weapon_controllers, "You need a ranged weapon to aim.")

        wielded_ranged_weapon_controller = ranged_weapon_controllers[0]

        return unless check_is_wielded(wielded_ranged_weapon_controller, "You will need to wield #{wielded_ranged_weapon_controller.short_desc} first.")

        return unless check_is_loaded(wielded_ranged_weapon_controller, "Load #{wielded_ranged_weapon_controller.short_desc} first.")

        target_info = room_controller.target_in_same_room(target)

        return unless check_target_present(target_info[:target], "You do not see that individual nearby.")

        @character_controller.aim_controller.start_aim_thread(target_info)

        room_controller.emit_action_echo("aim_simple", { emitter: @character_controller, target_info: target_info })
      end
    end
  end
end
