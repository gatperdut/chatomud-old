module ChatoMud
  module Actions
    class ActivateIncomplete < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx("Which non-possessed NPC do you want to activate? 'activate *' to calm all.")
      end
    end
  end
end
