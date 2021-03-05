require "mixins/fluids/definition"
require "mixins/fluids/utils"

module ChatoMud
  module Mixins
    module Items
      module AmountDataFluid
        include Fluids::Definition
        include Fluids::Utils

        def fluid
          model.amount_data.fluid
        end

        def fluid_colorized
          color = fluid_color[fluid.to_sym]
          fluid.send(color)
        end

        def nourishment(amount)
          {
            calories:  fluid_calories_per_unit(fluid)  * amount,
            hydration: fluid_hydration_per_unit(fluid) * amount
          }
        end
      end
    end
  end
end
