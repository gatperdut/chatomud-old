require "controllers/rooms/door_controller"

module ChatoMud
  module Handlers
    class DoorsHandler
      def initialize(server)
        @server = server
        @door_controllers = []
      end

      def bye
        @door_controllers.each(&:bye)
        @door_controllers.clear
      end

      def load_doors
        Door.all.each do |door|
          Controllers::Rooms::DoorController.new(@server, door)
        end
      end

      def report
        text = "*** DOORS HANDLER\n"
        text << "#{@door_controllers.count} doors loaded.\n"
        text
      end

      def add_door_controller(door_controller)
        @door_controllers << door_controller
      end

      def remove_door_controller(door_controller)
        @door_controllers.delete(door_controller)
      end

      def find(id)
        @door_controllers.select { |door_controller| door_controller.id == id }[0]
      end
    end
  end
end
