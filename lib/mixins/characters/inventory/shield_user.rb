module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module ShieldUser
          def shield_item_controllers
            held_item_controllers.select(&:is_shield?)
          end

          def using_shield?
            shield_item_controllers.count.positive?
          end
        end
      end
    end
  end
end
