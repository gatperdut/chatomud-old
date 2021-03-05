module ChatoMud
  module Actions
    class Snoop < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        if entity_controller.possession_controller.is_possessed?
          entity_controller.possession_controller.possessing_controller.tx("You cannot snoop from a possessed creature.", true)
          return
        end

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to snoop.")

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself.")

        if character_controller.entity_controller.possession_controller.is_possessing?
          tx("#{character_controller.short_desc} is already possessing or snooping.")
          return
        end

        if character_controller.entity_controller.possession_controller.is_possessed?
          tx("#{character_controller.short_desc} is already possessed or snooped.")
          return
        end

        # interrupt_ranged_weapon_handling

        @character_controller.entity_controller.possession_controller.possess(character_controller.entity_controller, true)
      end
    end
  end
end
