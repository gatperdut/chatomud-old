module ChatoMud
  module Actions
    class Kill < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        interrupt_ranged_weapon_handling

        tx("You kill #{character_controller.short_desc}.")
        character_controller.die
      end
    end
  end
end
