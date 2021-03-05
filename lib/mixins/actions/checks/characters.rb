module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Characters
          def check_character_is_not_possessed(character_controller, message = nil)
            if character_controller.entity_controller.possession_controller.is_possessed?
              tx(message) if message
              return false
            end
            true
          end

          def check_character_is_pc(character_controller, message = nil)
            unless character_controller.is_pc?
              tx(message) if message
              return false
            end
            true
          end

          def check_character_is_npc(character_controller, message = nil)
            unless character_controller.is_npc?
              tx(message) if message
              return false
            end
            true
          end

          def check_character_is_calmed_down(character_controller, message = nil)
            if character_controller.aasm_controller.active?
              tx(message) if message
              return false
            end
            true
          end

          def check_character_is_activated(character_controller, message = nil)
            if character_controller.aasm_controller.inactive?
              tx(message) if message
              return false
            end
            true
          end
        end
      end
    end
  end
end
