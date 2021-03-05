module ChatoMud
  module Actions
    class CloseDoor < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        direction = set_direction

        door_controller = door(direction)

        return unless check_target_present(door_controller, "There is no door leading #{direction}wards.")

        return unless check_container_or_door_is_open(door_controller, "#{door_controller.long_desc} is already closed.")

        interrupt_ranged_weapon_handling

        door_controller.close
        room_controller.emit_action_echo("close_door", { emitter: @character_controller, target: door_controller, direction: direction })
        other_room_controller = room_controller.send("room_#{direction}")
        other_room_controller.emit_action_echo("close_door_other_side", { door: door_controller })
      end
    end
  end
end
