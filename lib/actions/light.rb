module ChatoMud
  module Actions
    class Light < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        ground = bool!(:ground)
        off    = bool!(:off)

        if ground
          item_controller = @character_controller.search_item_controller(target, :room)
        else
          item_controller = @character_controller.search_item_controller(target, :held_or_room)
        end

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_light_source(item_controller, "#{item_controller.short_desc} is not a light source.")

        if item_controller.light_source_controller.must_be_held_to_light
          return unless check_is_in_character(item_controller, "You will need to pick up #{item_controller.short_desc} first.")
        end

        return unless check_light_is_not_eternal(item_controller.light_source_controller, "#{item_controller.short_desc} does not work that way.")

        if off
          return unless check_light_is_lit(item_controller.light_source_controller, "#{item_controller.short_desc} is not lit.")
        else
          return unless check_light_is_unlit(item_controller.light_source_controller, "#{item_controller.short_desc} is already lit.")
        end

        unless off
          return unless check_light_can_be_lit(item_controller.light_source_controller, "You cannot light #{item_controller.short_desc} - #{item_controller.light_source_controller.reason_cant_light}.")
        end

        room_controller.emit_action_echo("light", { emitter: @character_controller, target: item_controller, off: off })
        if off
          item_controller.light_source_controller.turn_off
        else
          item_controller.light_source_controller.turn_on
        end
      end
    end
  end
end
