require "mixins/characters/choices/paces/definition"
require "mixins/characters/choices/paces/utils"
require "mixins/characters/choices/stances/definition"

module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Set
          include Mixins::Characters::Choices::Paces::Definition
          include Mixins::Characters::Choices::Paces::Utils
          include Mixins::Characters::Choices::Stances::Definition

          def check_is_valid_stance(stance, message = nil)
            unless all_stances.include?(stance)
              tx(message) if message
              return
            end
            true
          end

          def check_is_valid_pace(pace, message = nil)
            unless all_paces.include?(pace)
              tx(message) if message
              return
            end
            true
          end

          def check_is_allowed_pace(pace, message = nil)
            unless allowed_paces(@character_controller.encumbrance_controller.encumbrance_penalty).include?(pace)
              tx(message) if message
              return
            end
            true
          end

          def check_is_valid_editor_echoes(editor_echo, message = nil)
            unless [:on, :off].include(editor_echo)
              tx(message) if message
              return
            end
            true
          end
        end
      end
    end
  end
end
