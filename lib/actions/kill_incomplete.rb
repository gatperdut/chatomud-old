module ChatoMud
  module Actions
    class KillIncomplete < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        tx("Please spell the full command, 'kill'.")
      end
    end
  end
end
