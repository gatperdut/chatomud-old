module ChatoMud
  module Actions
    class Grip < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        wielded_controllers = @character_controller.inventory_controller.wielded_item_controllers
        if wielded_controllers.empty?
          tx("You are not wielding anything.")
          return
        end

        if wielded_controllers.count == 2
          tx("You cannot switch your grip while dual-wielding.")
          return
        end

        wielded_controller = wielded_controllers[0]

        if wielded_controller.weapon_stat_controller.is_ranged? && !wielded_controller.weapon_stat_controller.ranged_stat_controller.can_remain_loaded?
          return unless check_is_not_loaded(wielded_controller, "You cannot shift your grip on #{wielded_controller.short_desc} while it is loaded.")
        end

        if wielded_controller.weapon_stat_controller.is_two_handed?
          tx("#{wielded_controller.short_desc} can be wielded only with both hands.")
          return
        end

        if wielded_controller.weapon_stat_controller.is_one_handed?
          tx("#{wielded_controller.short_desc} cannot be wielded with both hands.")
          return
        end

        interrupt_ranged_weapon_handling

        if wielded_controller.is_in_slot?(:w2hands)
          room_controller.emit_action_echo("grip", { emitter: @character_controller, target: wielded_controller, grip: :one_handed })
          wielded_controller.set_slot(:wrhand, true)
          return
        end

        held_controllers = @character_controller.inventory_controller.held_item_controllers
        unless held_controllers.empty?
          tx("You'll need to free your other hand to do that.")
          return
        end

        room_controller.emit_action_echo("grip", { emitter: @character_controller, target: wielded_controller, grip: :two_handed })
        wielded_controller.set_slot(:w2hands, true)
      end
    end
  end
end
