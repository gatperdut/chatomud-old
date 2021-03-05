module ChatoMud
  module Actions
    class LockDoor < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        direction = set_direction

        door_controller = door(direction)

        return unless check_target_present(door_controller, "There is no door leading #{direction}wards.")

        return unless check_container_or_door_is_closed(door_controller, "You'll need to close #{door_controller.long_desc} first.")

        return unless check_is_lockable(door_controller, "#{door_controller.long_desc} has no lock.")

        return unless check_is_unlocked(door_controller.lock_controller, "#{door_controller.long_desc} is already locked.")

        lockers = @character_controller.inventory_controller.lockers_for(door_controller.lock_controller)

        return unless check_count_is_positive(lockers, "You are not holding anything capable of locking #{door_controller.long_desc}.")

        interrupt_ranged_weapon_handling

        door_controller.lock_controller.lock
        room_controller.emit_action_echo("lock_door", { emitter: @character_controller, target: door_controller, with: lockers[0] })
        other_room_controller = room_controller.send("room_#{direction}")
        other_room_controller.emit_action_echo("lock_door_other_side", { door: door_controller })
      end
    end
  end
end
