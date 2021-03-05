require "mixins/directions/definition"
require "mixins/directions/utils"

module ChatoMud
  module Mixins
    module Rooms
      module Connected
        extend  Directions::Definition
        include Directions::Definition
        include Directions::Utils

        all_directions.each do |direction|
          define_method("room_#{direction}") do
            connecting_room_controller = model.send(abbreviature(direction) + "r")
            return nil unless connecting_room_controller

            @server.rooms_handler.find(connecting_room_controller.id)
          end

          define_method("door_#{direction}") do
            connecting_door_controller = model.send(abbreviature(direction) + "d")
            return nil unless connecting_door_controller

            @server.doors_handler.find(connecting_door_controller.id)
          end
        end

        def anchor
          all_directions.each do |direction|
            send("room_#{direction}")&.reload_model
          end
        end

        # { direction: [room_controller, direction_controller], etc }
        def connection(direction)
          result = nil

          connecting_room_controller = send("room_#{direction}")
          if connecting_room_controller
            result = [connecting_room_controller]
            connecting_door_controller = send("door_#{direction}")
            if connecting_door_controller
              result << connecting_door_controller
            end
          end

          result
        end

        def connections
          result = {}

          all_directions.each do |direction|
            result[direction] = connection(direction)
          end

          result.compact
        end

        def available_directions
          connections.compact.keys
        end

        def line_of_sight(direction, length)
          result = []
          length_travelled = 0
          current_room_controller = self

          while length_travelled < length
            conn = current_room_controller.connection(direction)

            break unless conn

            connecting_door_controller = conn[1]

            break unless !connecting_door_controller || connecting_door_controller.is_open?

            result << conn

            length_travelled += 1
            current_room_controller = current_room_controller.send("room_#{direction}")
          end

          result
        end

        def target_in_same_room(target)
          found_target = find_character_controller(target)

          if found_target
            return {
              target: found_target,
              direction: nil,
              distance: 0,
              room: self
            }
          end

          { target: nil }
        end

        def target_in_line_of_sight(character_controller, direction, length, target)
          los = line_of_sight(direction, length)

          los.each_with_index do |connection, index|
            connecting_room_controller = connection[0]

            next unless connecting_room_controller.can_be_seen_by_character?(character_controller)

            found_target = connecting_room_controller.find_character_controller(target)

            if found_target
              return {
                target: found_target,
                direction: direction,
                distance: index + 1,
                room: connecting_room_controller
              }
            end
          end

          { target: nil }
        end

        def list_connections(character_controller)
          return "It is too dark." unless can_be_seen_by_character?(character_controller)

          text = ""
          connections.each do |direction, connection|
            connecting_room_controller = connection[0]
            connecting_door_controller = connection[1]

            text << "Leading " << "#{direction}ward".ljust(15).cyan << "\t..."
            if !connecting_door_controller || connecting_door_controller.is_open?
              text << connecting_room_controller.title_formatted
            else
              text << "the #{connecting_door_controller.short_desc} is closed."
            end

            text << "\n"
          end

          text
        end
      end
    end
  end
end
