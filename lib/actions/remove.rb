module ChatoMud
  module Actions
    class Remove < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :worn_or_wielded)

        return unless check_target_present(item_controller, "You are not wearing '#{target[:word]}'.")

        interrupt_ranged_weapon_handling

        return unless check_character_can_hold(@character_controller, item_controller, "You will need a free hand to hold #{item_controller.short_desc}.")

        item_controller.set_slot(@character_controller.inventory_controller.get_hold_slot(item_controller), true)

        room_controller.emit_action_echo("remove", { emitter: @character_controller, target: item_controller })
      end
    end
  end
end
