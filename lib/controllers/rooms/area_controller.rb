require "controllers/base_controller"

module ChatoMud
  module Controllers
    module Rooms
      class AreaController < BaseController
        def initialize(server, area)
          super(server)
          @area = area
          @server.areas_handler.add_area_controller(self)
        end

        def reload_model
          @area = Area.find(@area.id)
        end

        def superarea_controller
          @server.superareas_handler.find(@area.superarea_id)
        end

        def broadcast_echo(text)
          @area.rooms.each do |room|
            @server.rooms_handler.find(room.id).emit_echo(nil, text)
          end
        end

        def bye
          @server.areas_handler.remove_area_controller(self)
        end

        def id
          @area.id
        end

        def name
          @area.name
        end
      end
    end
  end
end
