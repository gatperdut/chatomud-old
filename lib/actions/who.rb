module ChatoMud
  module Actions
    class Who < BaseAction
      def exec
        tx(@server.entities_handler.who)
      end
    end
  end
end
