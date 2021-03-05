require "controllers/rooms/superarea_controller"

module ChatoMud
  module Handlers
    class SuperareasHandler
      def initialize(server)
        @server = server
        @superarea_controllers = []
      end

      def bye
        @superarea_controllers.each(&:bye)
        @superarea_controllers.clear
      end

      def add_superarea_controller(superarea_controller)
        @superarea_controllers << superarea_controller
      end

      def remove_superarea_controller(superarea_controller)
        @superarea_controllers.delete(superarea_controller)
      end

      def report
        text = "*** SUPERAREAS HANDLER\n"
        text << "#{@superarea_controllers.size} superareas loaded.\n"
        @superarea_controllers.each do |superarea_controller|
          text << "#{superarea_controller.name}\n"
        end
        text
      end

      def find(id)
        @superarea_controllers.select { |superarea_controller| superarea_controller.id == id }[0]
      end

      def load_superareas
        Superarea.all.each do |superarea|
          Controllers::Rooms::SuperareaController.new(@server, superarea)
        end
      end
    end
  end
end
