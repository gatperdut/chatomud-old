module ChatoMud
  module Actions
    class ActivateAll < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        character_controllers = room_controller.npc_controllers

        character_controllers = character_controllers.reject do |character_controller|
          character_controller.entity_controller.possession_controller.is_possessed?
        end

        return unless check_count_is_positive(character_controllers, "There is noone here needing to be activated (only non-possessed NPCs are targeted.")

        tx("You activate all non-possessed NPCs.")

        character_controllers.each(&:activate)
      end
    end
  end
end
