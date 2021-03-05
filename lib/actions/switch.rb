module ChatoMud
  module Actions
    class Switch < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        if @character_controller.inventory_controller.find_item_controller_by_slot(:w2hands)
          tx("You cannot do that while wielding a two-handed weapon.")
          return
        end

        interrupt_ranged_weapon_handling

        left = @character_controller.inventory_controller.find_item_controller_by_slot(:lhand)
        left_new_slot = :rhand
        unless left
          left = @character_controller.inventory_controller.find_item_controller_by_slot(:wlhand)
          left_new_slot = :wrhand
        end

        right = @character_controller.inventory_controller.find_item_controller_by_slot(:rhand)
        right_new_slot = :lhand
        unless right
          right = @character_controller.inventory_controller.find_item_controller_by_slot(:wrhand)
          right_new_slot = :wlhand
        end

        unless left || right
          tx("You are not holding anything.")
          return
        end

        right&.set_slot(right_new_slot, true)
        left&.set_slot(left_new_slot, true)

        room_controller.emit_action_echo("switch", { emitter: @character_controller, left: left, right: right })
      end
    end
  end
end
