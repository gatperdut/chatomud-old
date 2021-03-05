require_all "lib/mixins/characters/echoes/receiver/**/*.rb"

require "controllers/characters/character_controller"
require "controllers/characters/aasm/aasm_controller"

module ChatoMud
  module Controllers
    module Characters
      class NpcController < CharacterController
        attr_reader :aasm_controller

        def initialize(server, character, room_controller)
          super(server, nil, character, room_controller)
          @aasm_controller = Aasm::AasmController.new(server, self, character.aasm)
        end

        def is_npc?
          true
        end

        def is_pc?
          false
        end

        def calmdown
          super
          @aasm_controller.deactivate
        end

        def activate
          @aasm_controller.activate
        end

        def interrupt_editing
          # Do nothing.
        end
      end
    end
  end
end
