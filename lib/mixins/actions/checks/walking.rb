module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Walking
          def check_has_enough_exhaustion_travel(character_controller, message = nil)
            unless character_controller.walking_controller.has_enough_exhaustion?
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
