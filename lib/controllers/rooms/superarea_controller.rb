require "controllers/base_controller"

module ChatoMud
  module Controllers
    module Rooms
      class SuperareaController < BaseController
        def initialize(server, superarea)
          super(server)
          @superarea = superarea
          @server.superareas_handler.add_superarea_controller(self)
        end

        def reload_model
          @superarea = Superarea.find(@superarea.id)
        end

        def broadcast_echo(text)
          @superarea.areas.each do |areas|
            @server.areas_handler.find(area.id).broadcast_echo(text)
          end
        end

        def bye
          @server.superareas_handler.remove_superarea_controller(self)
        end

        def id
          @superarea.id
        end

        def name
          @superarea.name
        end
      end
    end
  end
end
