module ChatoMud
  module Actions
    class Hit < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        if @character_controller.combat_controller.is_switching?
          tx("You are still getting your footing.")
          return
        end

        unless character_controller.combat_controller.can_be_attacked?
          tx("This character is fleeing. Give chase.")
          return
        end

        if @character_controller.combat_controller.target_is?(character_controller)
          tx("You are already doing your best!")
          return
        end

        if @character_controller.choice_controller.stance_is?(:pacifist)
          tx("Change to a non-pacifist stance first.")
          return
        end

        interrupt_ranged_weapon_handling

        character_controller.interrupt_editing

        @character_controller.combat_controller.fight(character_controller, true)
      end
    end
  end
end
