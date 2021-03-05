module ChatoMud
  module Actions
    class Time < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        tx(@server.timer.calendar.time_string)
      end
    end
  end
end
