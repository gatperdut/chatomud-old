module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module WeightCarrier
          def dead_weight
            @item_controllers.select(&:is_dead_weight?).map(&:weight).sum
          end
        end
      end
    end
  end
end
