module ChatoMud
  module Actions
    class Activate < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_character_is_npc(character_controller, "#{character_controller.short_desc} is not a NPC.")

        return unless check_character_is_not_possessed(character_controller, "#{character_controller.short_desc} is currently possessed.")

        return unless check_character_is_calmed_down(character_controller, "#{character_controller.short_desc} is already active.")

        tx("You activate #{character_controller.short_desc}.")

        character_controller.activate
      end
    end
  end
end
