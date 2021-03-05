module ChatoMud
  module Actions
    class Skills < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@character_controller.stats_controller.list_skill_set)
      end
    end
  end
end
