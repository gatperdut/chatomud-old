require "controllers/characters/aasm/types/aggro_aasm"
require "controllers/characters/aasm/types/wanderer_aasm"

module ChatoMud
  module Controllers
    module Characters
      module Aasm
        class AasmController
          attr_reader :character_controller
          attr_reader :aasm_handle

          def initialize(server, character_controller, aasm)
            @server = server
            @character_controller = character_controller
            @aasm = aasm

            @aasm_handle = Aasm::Types.const_get("#{@aasm.code}_aasm".to_s.camelize).new(@server, self)

            @aasm_handle.set_initial_state
          end

          def active?
            @aasm.active
          end

          def inactive?
            !active?
          end

          def activate
            @aasm.update(active: true) unless @aasm.active == true
            @aasm_handle.activate if @aasm_handle.may_activate?
          end

          def deactivate
            @aasm.update(active: false) unless @aasm.active == false
            @aasm_handle.calmdown if @aasm_handle.may_calmdown?
          end
        end
      end
    end
  end
end
