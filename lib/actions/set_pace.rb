module ChatoMud
  module Actions
    class SetPace < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        pace = @params[:pace].to_sym

        return unless check_is_valid_pace(pace, "'#{pace}' is not a valid pace.")

        return unless check_is_allowed_pace(pace, "Your movement is too restricted for that.")

        if @character_controller.choice_controller.pace_is?(pace)
          tx("You are already travelling at that pace.")
          return
        end

        @character_controller.choice_controller.pace!(pace)
        tx("From now on you will #{@character_controller.choice_controller.pace_colorized}.")
      end
    end
  end
end
