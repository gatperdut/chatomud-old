module ChatoMud
  module Actions
    class Rest < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        if position_controller.is_resting?
          tx("You are already resting.")
          return
        end

        interrupt_ranged_weapon_handling

        if position_controller.is_standing?
          room_controller.emit_action_echo("rest", { emitter: @character_controller, from: :standing })
          position_controller.rest
          return
        end

        if position_controller.is_sitting?
          room_controller.emit_action_echo("rest", { emitter: @character_controller, from: :sitting })
          position_controller.rest
          return
        end

        raise "resting with unknown position"
      end
    end
  end
end
