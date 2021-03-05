require "controllers/items/item_controller"

module ChatoMud
  module Handlers
    class ItemsHandler
      attr_reader :light_source_controllers

      def initialize(server)
        @server = server
        @item_controllers = []

        @light_source_controllers = []
      end

      def bye
        @item_controllers.each(&:bye)

        @item_controllers.clear
        @light_source_controllers.clear
      end

      def report
        text = "*** ITEMS HANDLER\n"
        text << "#{@item_controllers.size} items loaded.\n"
        text << "#{@light_source_controllers.size} light sources loaded.\n"
        text
      end

      def remove_item_controller(item_controller)
        @item_controllers.delete(item_controller)

        @light_source_controllers.delete(item_controller) if item_controller.is_light_source?
      end

      def add_item_controller(item_controller)
        @item_controllers << item_controller

        @light_source_controllers << item_controller if item_controller.is_light_source?
      end
    end
  end
end
