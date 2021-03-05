module ChatoMud
  module Actions
    class Pour < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        source = @params[:source]

        item_controller = @character_controller.search_item_controller(source, :carried)

        return unless check_target_present(item_controller, "You are not holding the '#{source[:word]}' to pour.")

        if check_is_fillable(item_controller)
          amount_controller = item_controller.fluid_controller
        elsif check_is_light_source(item_controller) && check_requires_liquid_fuel(item_controller.light_source_controller)
          amount_controller = item_controller.light_source_controller.capacity_controller
        else
          tx("You cannot pour #{item_controller.short_desc}.")
          return
        end

        return unless check_amount_is_positive(amount_controller, "#{item_controller.short_desc} is already empty.")

        room_controller.emit_action_echo("pour", { emitter: @character_controller, source: item_controller, amount: amount_controller })
        amount_controller.consume(amount_controller.current)
      end
    end
  end
end
