module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Rooms
          def check_room_can_be_seen_by(room_controller, character_controller, message = nil)
            unless room_controller.can_be_seen_by_character?(character_controller)
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
