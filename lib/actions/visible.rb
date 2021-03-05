module ChatoMud
  module Actions
    class Visible < BaseAction
      def exec
        if @character_controller.visibility_controller.is_visible?
          tx("You are already visible ...")
          return
        end

        @character_controller.visibility_controller.turn(true)

        tx("You make yourself visible.")
      end
    end
  end
end
