module ChatoMud
  module Actions
    class Invisible < BaseAction
      def exec
        if @character_controller.visibility_controller.is_invisible?
          tx("You are already invisible.")
          return
        end

        @character_controller.visibility_controller.turn(false)

        tx("You make yourself invisible.")
      end
    end
  end
end
