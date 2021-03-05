module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Inventories
          def check_character_can_hold(character_controller, item_controller, message = nil)
            unless character_controller.inventory_controller.can_hold?(item_controller)
              tx(message) if message
              return false
            end
            true
          end

          def check_has_content(inventory_controller, message = nil)
            unless inventory_controller.has_content?
              tx(message) if message
              return false
            end
            true
          end

          def check_has_no_content(inventory_controller, message = nil)
            if inventory_controller.has_content?
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
