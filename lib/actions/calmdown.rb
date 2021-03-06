module ChatoMud
  module Actions
    class Calmdown < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_character_is_not_possessed(character_controller, "#{character_controller.short_desc} is currently possessed.")

        if character_controller.is_npc?
          return unless check_character_is_activated(character_controller, "#{character_controller.short_desc} is already calmed down.")
        end

        tx("You calm #{character_controller.short_desc} down.")

        character_controller.calmdown
      end
    end
  end
end
