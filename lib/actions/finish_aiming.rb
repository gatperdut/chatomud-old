module ChatoMud
  module Actions
    class FinishAiming < BaseAction
      def exec
        tx("You feel you have the best aim you are going to get.")
      end
    end
  end
end
