require "mixins/items/amounts"
require "mixins/items/amount_data_food"

module ChatoMud
  module Controllers
    module Items
      module Amounts
        class FoodController
          include Mixins::Items::Amounts
          include Mixins::Items::AmountDataFood

          def initialize(item_controller, food)
            @item_controller = item_controller
            @food = food
          end

          def handle_reduced_stack
            @food.current = @food.max
          end

          def handle_consume
            @item_controller.stack_controller.consume(1) if is_empty?
          end

          def current_portion_description
            case percentage
              when 0.00..0.20
                "no more than a few remaining scraps"
              when 0.20..0.40
                "mostly eaten"
              when 0.40..0.60
                "half-eaten"
              when 0.60..0.80
                "partly-eaten"
              when 0.80..0.99
                "barely touched"
              when 1.00
                "untouched"
              else
                raise "Invalid percentage for food current portion description"
            end
          end

          def taken_portion_description(amount)
            case percentage(amount)
              when 0.00..0.20
                "a bite of"
              when 0.20..0.40
                "a few bites of"
              when 0.40..0.60
                "half of"
              when 0.60..0.80
                "most of"
              when 0.80..0.99
                "almost all of"
              when 1.00
                "all of"
              else
                raise "Invalid percentage for food taken portion description"
            end
          end

          def model
            @food
          end
        end
      end
    end
  end
end
