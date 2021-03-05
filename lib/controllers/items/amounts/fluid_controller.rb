require "mixins/items/amounts"
require "mixins/items/amount_data_fluid"

module ChatoMud
  module Controllers
    module Items
      module Amounts
        class FluidController
          include Mixins::Items::Amounts
          include Mixins::Items::AmountDataFluid

          def initialize(item_controller, fluid)
            @item_controller = item_controller
            @fluid = fluid
          end

          def handle_consume
            # Do nothing.
          end

          def current_portion_description
            case percentage
              when 0.00..0.20
                "almost out of"
              when 0.20..0.40
                "holding some"
              when 0.40..0.60
                "half full of"
              when 0.60..0.80
                "quite full of"
              when 0.80..0.99
                "mostly full of"
              when 1.00
                "full of"
              else
                raise "Invalid percentage for fluid current portion description."
            end
          end

          def taken_portion_description(amount)
            case percentage(amount)
              when 0.00..0.20
                "a little of the"
              when 0.20..0.40
                "some of the"
              when 0.40..0.60
                "half of the"
              when 0.60..0.80
                "a lot of the"
              when 0.80..0.99
                "almost all of the"
              when 0.80..1.00
                "all of the"
              else
                raise "Invalid percentage for fluid taken portion description."
            end
          end

          def model
            @fluid
          end
        end
      end
    end
  end
end
