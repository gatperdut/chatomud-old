require "controllers/characters/aasm/types/common_aasm"

module ChatoMud
  module Controllers
    module Characters
      module Aasm
        module Types
          class AggroAasm < CommonAasm
            aasm do
              # Empty.
            end

            def do_action
              super
              target_controllers = room_controller.character_controllers.select do |character_controller|
                character_controller.is_pc? && character_controller.combat_controller.can_be_attacked?
              end

              attack(:attacking, target_controllers[0]) if target_controllers[0].present?
            end
          end
        end
      end
    end
  end
end
