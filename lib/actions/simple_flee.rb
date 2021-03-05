module ChatoMud
  module Actions
    class SimpleFlee < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :not_in_combat])

        directions = @character_controller.room_controller.available_directions

        return unless check_count_is_positive(directions, "There is nowhere to flee!")

        if @character_controller.combat_controller.is_fleeing?
          tx("You are already doing your best to get away!")
          return
        end

        @character_controller.combat_controller.flee(directions.sample, true)
      end
    end
  end
end
