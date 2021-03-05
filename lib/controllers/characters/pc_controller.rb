require "controllers/characters/character_controller"
require "controllers/characters/editing_controller"

module ChatoMud
  module Controllers
    module Characters
      class PcController < CharacterController
        attr_reader :editing_controller

        def initialize(server, player_controller, character, room_controller)
          super(server, player_controller, character, room_controller)

          @editing_controller = EditingController.new(server, self)
        end

        def is_npc?
          false
        end

        def is_pc?
          true
        end

        def interrupt_editing
          @editing_controller.interrupt_editing
        end
      end
    end
  end
end
