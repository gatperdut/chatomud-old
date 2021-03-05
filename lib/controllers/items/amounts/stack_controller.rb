require "mixins/items/amounts"

module ChatoMud
  module Controllers
    module Items
      module Amounts
        class StackController
          include Mixins::Items::Amounts

          def initialize(item_controller, stack)
            @item_controller = item_controller
            @stack = stack
          end

          def handle_consume
            if is_empty?
              @item_controller.junk(true)
            else
              if @item_controller.is_edible?
                @item_controller.food_controller.set_to_max
              end
            end
          end

          def model
            @stack
          end
        end
      end
    end
  end
end
