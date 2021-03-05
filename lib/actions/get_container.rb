module ChatoMud
  module Actions
    class GetContainer < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        source = @params[:source]
        amount = min_amount(nil)

        return unless check_is_valid_amount(amount, "Please provide a valid amount.")

        source_controller = @character_controller.search_item_controller(source, :anywhere)
        source_controller ||= @character_controller.search_furniture_controller(source)

        return unless check_target_present(source_controller, "You cannot find the '#{source[:word]}'.")

        return unless check_is_container(source_controller, "#{source_controller.short_desc} is not a container.")

        if check_is_closable(source_controller.inventory_controller)
          return unless check_container_or_door_is_open(source_controller.inventory_controller.lid_controller, "#{source_controller.short_desc} is closed.")
        end

        target_item_controller = source_controller.inventory_controller.find_item_controller(target)

        return unless check_target_present(target_item_controller, "You cannot find the '#{target[:word]}' inside #{source_controller.short_desc}.")

        return unless check_character_can_hold(@character_controller, target_item_controller, "You will need a free hand to hold #{target_item_controller.short_desc}.")

        if amount
          return unless check_is_stackable(target_item_controller, "#{target_controller.short_desc} is not a stack.")

          return unless check_has_amount_of_at_least(target_item_controller.stack_controller, amount, "There are not that many of #{target_item_controller.short_desc} to take.")

          interrupt_ranged_weapon_handling

          new_item_controller = handle_spawned_stack(target_item_controller, amount, @character_controller.inventory_controller)
          echo(source_controller, new_item_controller)
        else
          interrupt_ranged_weapon_handling

          @character_controller.inventory_controller.accept_item(target_item_controller, true)
          echo(source_controller, target_item_controller)
        end
      end

      def echo(source_controller, target_item_controller)
        room_controller.emit_action_echo("get_container", { emitter: @character_controller, source: source_controller, target: target_item_controller })
      end
    end
  end
end
