module ChatoMud
  module Actions
    class Retreat < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :not_in_combat])

        unless @character_controller.group_controller.is_grouped? && @character_controller.group_controller.is_leading?
          tx("\nYou must be leading a group to use this command.\n")
          return
        end

        direction = @params[:direction].keys[0]

        directions = @character_controller.room_controller.available_directions

        unless directions.include?(direction)
          tx("You cannot order your group to retreat that way!")
          return
        end

        @character_controller.combat_controller.group_flee(direction)
      end
    end
  end
end
