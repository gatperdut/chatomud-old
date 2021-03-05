module ChatoMud
  module Mixins
    module Inventories
      module WeightBearer
        def borne_weight
          @item_controllers.sum(&:weight)
        end
      end
    end
  end
end
