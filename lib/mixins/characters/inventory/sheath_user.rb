module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module SheathUser
          # :any, :empty, :full
          def sheath_item_controllers(where)
            send("sheath_item_controllers_#{where}")
          end

          private

          def sheath_item_controllers_any
            item_controllers_ordered_by_slot.select(&:is_sheath?)
          end

          def sheath_item_controllers_full
            sheath_item_controllers_any.select do |item_controller|
              item_controller.inventory_controller.has_content?
            end
          end

          def sheath_item_controllers_empty
            sheath_item_controllers_any.reject do |item_controller|
              item_controller.inventory_controller.has_content?
            end
          end
        end
      end
    end
  end
end
