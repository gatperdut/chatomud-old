module ChatoMud
  module Actions
    class Junk < BaseAction
      # TODO: add amount
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        item_controller = @character_controller.search_item_controller(target, :held_or_wielded)

        return unless check_target_present(item_controller, "You are not holding that.")

        return unless check_not_in_use(item_controller, "#{item_controller.short_desc} is being used right now.")

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("junk", { emitter: @character_controller, target: item_controller })

        item_controller.junk(true)
      end
    end
  end
end
