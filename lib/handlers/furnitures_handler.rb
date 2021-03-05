module ChatoMud
  module Handlers
    class FurnituresHandler
      def initialize(server)
        @server = server
        @furniture_controllers = []
      end

      def bye
        @furniture_controllers.each(&:bye)
        @furniture_controllers.clear
      end

      def report
        text = "*** FURNITURES HANDLER\n"
        text << "#{@furniture_controllers.size} pieces of furniture loaded.\n"
        text
      end

      def remove_item_controller(furniture_controller)
        @furniture_controllers.delete(furniture_controller)
      end

      def add_item_controller(furniture_controller)
        @furniture_controllers << furniture_controller
      end

      def find(id)
        @furniture_controllers.select { |furniture_controller| furniture_controller.id == id }[0]
      end
    end
  end
end
