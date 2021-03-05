module ChatoMud
  module Actions
    class Awho < BaseAction
      def exec
        tx(@server.characters_handler.awho)
      end
    end
  end
end
