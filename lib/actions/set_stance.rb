module ChatoMud
  module Actions
    class SetStance < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        stance = @params[:stance].to_sym

        return unless check_is_valid_stance(stance, "'#{stance}' is not a valid stance.")

        if @character_controller.choice_controller.stance_is?(stance)
          tx("You are already in that stance.")
          return
        end

        @character_controller.choice_controller.stance!(stance)
        tx("Your shift your stance to #{stance.to_s.cyan}.")

        @character_controller.combat_controller.handle_become_pacifist if @character_controller.choice_controller.stance_is?(:pacifist)
        @character_controller.combat_controller.handle_become_belligerent unless @character_controller.choice_controller.stance_is?(:pacifist)
      end
    end
  end
end
