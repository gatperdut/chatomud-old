module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Closable
          def check_is_closable(inventory_controller, message = nil)
            unless inventory_controller.is_closable?
              tx(message) if message
              return false
            end
            true
          end

          def check_container_or_door_is_closed(target_controller, message = nil)
            unless target_controller.is_closed?
              tx(message) if message
              return false
            end
            true
          end

          def check_container_or_door_is_open(target_controller, message = nil)
            unless target_controller.is_open?
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
