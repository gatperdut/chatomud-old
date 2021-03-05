require "mixins/directions/definition"
require "mixins/directions/utils"

module ChatoMud
  module Mixins
    module Rooms
      module Doors
        module Connected
          extend  Directions::Definition
          include Directions::Definition
          include Directions::Utils

          all_directions.each do |direction|
            define_method("room_#{direction}") do
              connecting_room_controller = @door.send(abbreviature(direction) + "r")
              return nil unless connecting_room_controller

              @server.rooms_handler.find(connecting_room_controller.id)
            end
          end

          def anchor
            all_directions.each do |direction|
              room = send("room_#{direction}")
              room&.reload_model
            end
          end
        end
      end
    end
  end
end
