module ChatoMud
  module Actions
    class Group < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        include_invisible = @character_controller.visibility_controller.is_invisible?

        tx("\n#{@character_controller.group_controller.list_group(include_invisible)}\n")
      end
    end
  end
end
