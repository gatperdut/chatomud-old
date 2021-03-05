module ChatoMud
  module Actions
    class Eat < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        ground = bool!(:ground)
        amount = min_amount(1)

        return unless check_is_valid_amount(amount, "Please provide a valid amount.")

        if ground
          item_controller = @character_controller.search_item_controller(target, :room)
        else
          item_controller = @character_controller.search_item_controller(target, :held_or_room)
        end

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}' to eat.")

        return unless check_is_edible(item_controller, "You cannot eat #{item_controller.short_desc}.")

        return unless check_has_amount_of_at_least(item_controller.food_controller, amount, "You cannot eat that much of #{item_controller.short_desc}.")

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("eat", { emitter: @character_controller, target: item_controller, amount: amount })

        item_controller.food_controller.consume(amount)

        nourishment = item_controller.food_controller.nourishment(amount)

        @character_controller.nourishment_controller.replenish_nourishment(nourishment[:calories], nourishment[:hydration])
      end
    end
  end
end
