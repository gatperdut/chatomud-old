require "controllers/rooms/area_controller"

module ChatoMud
  module Handlers
    class AreasHandler
      def initialize(server)
        @server = server
        @area_controllers = []
      end

      def bye
        @area_controllers.each(&:bye)
        @area_controllers.clear
      end

      def add_area_controller(area_controller)
        @area_controllers << area_controller
      end

      def remove_area_controller(area_controller)
        @area_controllers.delete(area_controller)
      end

      def report
        text = "*** AREAS HANDLER\n"
        text << "#{@area_controllers.size} areas loaded.\n"
        @area_controllers.each do |area_controller|
          text << "#{area_controller.name}\n"
        end
        text
      end

      def find(id)
        @area_controllers.select { |area_controller| area_controller.id == id }[0]
      end

      def load_areas
        Area.all.each do |area|
          Controllers::Rooms::AreaController.new(@server, area)
        end
      end
    end
  end
end
