module ChatoMud
  module Actions
    class UnlockDoor < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        direction = set_direction

        door_controller = door(direction)

        return unless check_target_present(door_controller, "There is no door leading #{direction}wards.")

        return unless check_is_lockable(door_controller, "#{door_controller.long_desc} has no lock.")

        return unless check_is_locked(door_controller.lock_controller, "#{door_controller.long_desc} is already unlocked.")

        lockers = @character_controller.inventory_controller.lockers_for(door_controller.lock_controller)

        return unless check_count_is_positive(lockers, "You are not holding anything capable of unlocking #{door_controller.long_desc}.")

        interrupt_ranged_weapon_handling

        door_controller.lock_controller.unlock
        room_controller.emit_action_echo("unlock_door", { emitter: @character_controller, target: door_controller, with: lockers[0] })
        other_room_controller = room_controller.send("room_#{direction}")
        other_room_controller.emit_action_echo("unlock_door_other_side", { door: door_controller })
      end
    end
  end
end
