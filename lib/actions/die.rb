module ChatoMud
  module Actions
    class Die < BaseAction
      def exec
        @character_controller.die
      end
    end
  end
end
