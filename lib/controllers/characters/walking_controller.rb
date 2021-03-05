require "mixins/characters/walking/pacer"

require "mixins/directions/utils"

require "actions/look_around"

module ChatoMud
  module Controllers
    module Characters
      class WalkingController
        include Mixins::Characters::Walking::Pacer
        include Mixins::Directions::Utils

        attr_reader :direction
        attr_reader :fleeing

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
          @walking_thread = nil
          @direction = nil
        end

        def bye
          stop_walking
        end

        def start_walking(direction, fleeing)
          consume_exhaustion

          @direction = direction
          new_room_controller = @character_controller.room_controller.send("room_#{direction}")

          @walking_thread = Thread.new(self, @character_controller, direction, new_room_controller) do |thread_walking_controller, thread_character_controller, thread_direction, thread_new_room_controller|
            sleep(travel_time)
            current_room = @character_controller.room_controller
            door_controller = current_room.send("door_" + thread_direction.to_s)
            if door_controller&.is_closed?
              current_room.emit_action_echo("stop_closed_door", { emitter: thread_character_controller, door_controller: door_controller })
            else
              new_room_controller.accept_character(thread_character_controller, true)
              Actions::LookAround.new(@server, @character_controller, nil).exec
              from = opposite_as_from(thread_direction)
              new_room_controller.emit_action_echo("arrival", { emitter: thread_character_controller, from: from, fleeing: fleeing })
              @character_controller.combat_controller.update_aimers(:moved, { direction: @direction, fleeing: fleeing })
            end
            @direction = nil
          end
        end

        def flee(direction)
          @character_controller.room_controller.emit_action_echo("direction", { emitter: @character_controller, direction: direction, fleeing: true })
          start_walking(direction, true)
        end

        def is_walking?
          @walking_thread.present? && @walking_thread.alive?
        end

        def stop_walking
          @walking_thread&.terminate
          @walking_thread = nil
          @direction      = nil
        end
      end
    end
  end
end
