module ChatoMud
  module Actions
    class Wield < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        target_controller = @character_controller.search_item_controller(target, :held)
        unless target_controller
          target_controller = @character_controller.search_item_controller(target, :wielded)

          tx("You are already wielding #{target_controller.short_desc}.") and return if target_controller

          tx("You are not holding the '#{target[:word]}'.")
          return
        end

        return unless check_is_weapon(target_controller, "#{target_controller.short_desc} is not a weapon.")

        return unless check_can_wield(target_controller)

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("wield", { emitter: @character_controller, target: target_controller })

        @character_controller.inventory_controller.wield(target_controller)
      end
    end
  end
end
