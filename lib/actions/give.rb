module ChatoMud
  module Actions
    class Give < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        receiver = @params[:receiver]
        amount = min_amount(nil)

        return unless check_is_valid_amount(amount, "Please provide a valid amount.")

        item_controller = @character_controller.search_item_controller(target, :carried)

        return unless check_target_present(item_controller, "You are not holding the '#{target[:word]}'.")

        interrupt_ranged_weapon_handling

        receiver_character_controller = @character_controller.search_character_controller(receiver)

        return unless check_target_present(receiver_character_controller, "Who do you want to give #{item_controller.short_desc} to?")

        return unless check_no_equality(@character_controller, receiver_character_controller, "You cannot target yourself.")

        return unless check_is_not_loading(receiver_character_controller, "#{receiver_character_controller.short_desc} is loading a weapon and cannot take the item right now.")

        unless check_character_can_hold(receiver_character_controller, item_controller)
          room_controller.emit_action_echo("give_failed", { emitter: @character_controller, receiver: receiver_character_controller, target: item_controller })
          return
        end

        if amount
          return unless check_is_stackable(item_controller, "#{item_controller.short_desc} is not a stack.")

          return unless check_has_amount_of_at_least(item_controller.stack_controller, amount, "There are not that many of #{item_controller.short_desc} to give.")

          new_item_controller = handle_spawned_stack(item_controller, amount, receiver_character_controller.inventory_controller)
          echo(receiver_character_controller, new_item_controller)
        else
          receiver_character_controller.inventory_controller.accept_item(item_controller, true)
          echo(receiver_character_controller, item_controller)
        end
      end

      def echo(receiver_character_controller, item_controller)
        room_controller.emit_action_echo("give", { emitter: @character_controller, receiver: receiver_character_controller, target: item_controller })
      end
    end
  end
end
