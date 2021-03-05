module ChatoMud
  module Actions
    class CalmdownAll < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        character_controllers = room_controller.character_controllers

        return unless check_count_is_positive(character_controllers, "There is noone here needing to be calmed down.")

        tx("You calm all down.")

        character_controllers.each(&:calmdown)
      end
    end
  end
end
