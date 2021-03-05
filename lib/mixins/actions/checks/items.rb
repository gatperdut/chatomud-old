module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Items
          def check_not_in_use(item_controller, message = nil)
            if item_controller.in_use == true
              tx(message) if message
              return false
            end
            true
          end

          def check_is_in_character(item_controller, message = nil)
            unless item_controller.in_character?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_in_room(item_controller, message = nil)
            unless item_controller.in_room?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_in_item(item_controller, message = nil)
            unless item_controller.in_item?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_in_furniture(item_controller, message = nil)
            unless item_controller.in_furniture?
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
