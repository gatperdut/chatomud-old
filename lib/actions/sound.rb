module ChatoMud
  module Actions
    class Sound < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :held_or_room)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        unless item_controller.is_horn?
          tx("#{item_controller.short_desc} cannot be used in that way.")
          return
        end

        room_controller.emit_action_echo("sound", { emitter: @character_controller, target: item_controller })

        controller = room_controller.area_controller if item_controller.horn_property_controller.reach == :area
        controller = room_controller.area_controller.superarea_controller if item_controller.horn_property_controller.reach == :superarea

        controller.broadcast_echo(item_controller.horn_property_controller.echo)
      end
    end
  end
end
