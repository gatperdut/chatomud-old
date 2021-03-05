module ChatoMud
  module Actions
    class SimpleWear < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :held)

        return unless check_target_present(item_controller, "You are not holding the '#{target[:word]}'.")

        unless item_controller.is_wearable?
          tx("#{item_controller.short_desc} cannot be worn.")
          return
        end

        slot = nil
        item_controller.possible_slots.each do |possible_slot|
          if @character_controller.inventory_controller.is_slot_free?(possible_slot.to_sym)
            slot = possible_slot
            break
          end
        end

        unless slot
          tx("All possible places where you could wear #{item_controller.short_desc} are claimed.")
          return
        end

        interrupt_ranged_weapon_handling

        item_controller.set_slot(slot, true)
        room_controller.emit_action_echo("wear", { emitter: @character_controller, target: item_controller, slot: slot })
      end
    end
  end
end
