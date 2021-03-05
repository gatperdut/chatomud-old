module ChatoMud
  module Actions
    class RetreatIncomplete < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :not_in_combat])

        unless @character_controller.group_controller.is_grouped? && @character_controller.group_controller.is_leading?
          tx("\nYou must be leading a group to use this command.\n")
          return
        end

        tx("\nThis command requires a direction. Use FLEE if you want to abandon your group and flee on your own.\n")
      end
    end
  end
end
