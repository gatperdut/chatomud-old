module ChatoMud
  module Actions
    class PourInto < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        source = @params[:source]
        target = @params[:target]
        ground = bool!(:ground)

        source_item_controller = @character_controller.search_item_controller(source, :carried)

        return unless check_target_present(source_item_controller, "You are not holding the '#{source[:word]}' to pour.")

        if check_is_fillable(source_item_controller)
          source_amount_controller = source_item_controller.fluid_controller
        elsif check_is_light_source(source_item_controller) && check_requires_liquid_fuel(source_item_controller.light_source_controller)
          source_amount_controller = source_item_controller.light_source_controller.capacity_controller
        else
          tx("You cannot pour #{source_item_controller.short_desc}.")
          return
        end

        return unless check_amount_is_positive(source_amount_controller, "#{source_item_controller.short_desc} is already empty.")

        if ground
          target_item_controller = @character_controller.search_item_controller(target, :room)
        else
          target_item_controller = @character_controller.search_item_controller(target, :held_or_room)
        end

        return unless check_target_present(target_item_controller, "You cannot find the '#{source[:word]}' to pour #{source_item_controller.short_desc} into.")

        if check_is_fillable(target_item_controller)
          target_amount_controller = target_item_controller.fluid_controller
        elsif check_is_light_source(target_item_controller) && check_requires_liquid_fuel(target_item_controller.light_source_controller)
          target_amount_controller = target_item_controller.light_source_controller.capacity_controller
        else
          tx("You cannot pour into #{target_item_controller.short_desc}.")
          return
        end

        return unless check_amount_is_not_max(target_amount_controller, "You cannot pour anything into #{target_item_controller.short_desc} - it is already full.")

        if check_is_light_source(target_item_controller)
          return unless check_is_valid_liquid_fuel(target_item_controller.light_source_controller.liquid_fuel_req_controller, source_amount_controller.fluid, "#{target_item_controller.short_desc} cannot be fueled with #{source_amount_controller.fluid_colorized}.")
        end

        if check_amount_is_positive(target_amount_controller)
          return unless check_fluids_match(target_amount_controller, source_amount_controller, "You cannot mix different fluids.")
        end

        amount = [source_amount_controller.current, target_amount_controller.left_to_max].min

        room_controller.emit_action_echo("pour_into", { emitter: @character_controller, source: source_item_controller, target: target_item_controller, amount: source_amount_controller })
        source_amount_controller.consume(amount)
        target_amount_controller.add(amount, source_amount_controller.fluid)
      end
    end
  end
end
