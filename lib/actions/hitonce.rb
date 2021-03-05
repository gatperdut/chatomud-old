module ChatoMud
  module Actions
    # DEBUG
    class HitOnce < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        if @character_controller.combat_controller.target_is?(character_controller)
          tx("You are already doing your best!")
          return
        end

        if @character_controller.choice_controller.stance_is?(:pacifist)
          tx("Change to a non-pacifist stance first.")
          return
        end

        @character_controller.combat_controller.perform_melee_attacks(character_controller)
      end
    end
  end
end
