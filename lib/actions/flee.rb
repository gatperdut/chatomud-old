module ChatoMud
  module Actions
    class Flee < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :not_in_combat])

        direction = @params[:direction].keys[0]

        directions = @character_controller.room_controller.available_directions

        unless directions.include?(direction)
          tx("You cannot flee that way!")
          return
        end

        return unless check_has_enough_exhaustion_travel(@character_controller, "You are too exhausted.")

        if @character_controller.combat_controller.is_fleeing?
          if direction == @character_controller.combat_controller.flee_direction
            tx("You are already trying to flee in that direction!")
            return
          end
          room_controller.emit_action_echo("flee_change", { emitter: @character_controller })
          @character_controller.combat_controller.stop_fleeing(false)
          @character_controller.combat_controller.flee(direction, false)
        end

        @character_controller.combat_controller.flee(direction, true)
      end
    end
  end
end
