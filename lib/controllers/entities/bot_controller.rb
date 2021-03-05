require "controllers/entities/entity_controller"
require "controllers/characters/npc_controller"

module ChatoMud
  module Controllers
    module Entities
      class BotController < EntityController
        def initialize(server, character_controller)
          super(server, nil)
          @character_controller = character_controller
          @character_controller.entity_controller = self

          @character_controller.emit_enter_area

          @character_controller.aasm_controller.aasm_handle.start_clock_thread
        end

        def handle_character_death
          super
          bye
        end

        def tx(message, vessel = false)
          return unless @possession_controller.is_possessed?

          return if vessel

          @possession_controller.possessing_controller.tx(message, true)
        end

        def is_waiting_for_reconnection?
          false
        end

        def show_prompt
          # Empty.
        end

        def is_player?
          false
        end

        def is_editing?
          false
        end

        def is_bot?
          true
        end

        def log(content)
          # Empty
        end
      end
    end
  end
end
