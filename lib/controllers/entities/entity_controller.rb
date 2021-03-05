require "controllers/entities/possession/possession_controller"

module ChatoMud
  module Controllers
    module Entities
      class EntityController
        attr_reader :character_controller
        attr_reader :possession_controller

        def initialize(server, thread)
          @server = server
          @thread = thread
          @possession_controller = PossessionController.new(@server, self)
          @server.entities_handler.add_entity_controller(self)
        end

        def bye
          @server.entities_handler.remove_entity_controller(self)
          @character_controller&.bye
          @thread&.terminate
        end

        def handle_character_death
          @character_controller = nil
        end

        def handle_command(command)
          @character_controller.interpret(command)
        end
      end
    end
  end
end
