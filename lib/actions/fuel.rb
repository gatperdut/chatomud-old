module ChatoMud
  module Actions
    class Fuel < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        source = @params[:source]

        target_item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(target_item_controller, "You cannot find the '#{target[:word]}' to fuel.")

        source_item_controller = @character_controller.search_item_controller(source, :held_or_room)

        return unless check_target_present(source_item_controller, "You cannot find the '#{source[:word]}' to fuel #{target_item_controller.short_desc}.")

        unless check_is_light_source(target_item_controller) && check_requires_solid_fuel(target_item_controller.light_source_controller)
          tx("#{target_item_controller.short_desc} cannot be fueled.")
          return
        end

        return unless check_is_valid_solid_fuel(target_item_controller.light_source_controller.solid_fuel_req_controller, source_item_controller, "#{target_item_controller.short_desc} cannot be fueled with #{source_item_controller.short_desc}.")

        return unless check_amount_is_not_max(target_item_controller.light_source_controller.capacity_controller, "#{target_item_controller.short_desc} does not need any more fuel right now.")

        room_controller.emit_action_echo("fuel", { emitter: @character_controller, target: target_item_controller, source: source_item_controller })

        if source_item_controller.is_stackable?
          source_item_controller.stack_controller.consume(1)
        else
          source_item_controller.junk(true)
        end
        target_item_controller.light_source_controller.capacity_controller.add(1)
      end
    end
  end
end
