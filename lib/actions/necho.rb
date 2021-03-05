module ChatoMud
  module Actions
    class Necho < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        name   = @params[:name].to_s.downcase
        speech = @params[:speech].to_s

        character_controller = @server.characters_handler.find_by_name(name)

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
