module ChatoMud
  module Actions
    class Pecho < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        speech = @params[:speech].to_s

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        their_possession_controller = character_controller.entity_controller.possession_controller

        if their_possession_controller.is_possessing?
          tx("#{character_controller.short_desc} is currently possessing #{their_possession_controller.possessed_controller.character_controller.short_desc}.")
          return
        end

        character_controller.tx("\n#{speech}\n")

        tx("#{character_controller.short_desc} receives:\n\n#{speech}\n")
      end
    end
  end
end
