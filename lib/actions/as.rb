module ChatoMud
  module Actions
    class As < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        speech = @params[:speech].to_s

        if entity_controller.possession_controller.is_possessed?
          entity_controller.possession_controller.possessing_controller.tx("You cannot use this command from a possessed creature.", true)
          return
        end

        character_controller = @character_controller.search_character_controller(target)

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        return unless check_target_present(character_controller, "You cannot find that character.")

        result = character_controller.interpret(speech, @character_controller)

        tx("\nSomething is wrong with that command. Try POSSESS.\n") unless result
      end
    end
  end
end
