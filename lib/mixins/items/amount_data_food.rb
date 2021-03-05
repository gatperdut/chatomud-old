module ChatoMud
  module Mixins
    module Items
      module AmountDataFood
        def calories_per_stack_unit
          model.amount_data.calories
        end

        def calories_per_unit
          (calories_per_stack_unit / model.max).round
        end

        def hydration_per_stack_unit
          model.amount_data.hydration
        end

        def hydration_per_unit
          (hydration_per_stack_unit / model.max).round
        end

        def nourishment(amount)
          {
            calories:  calories_per_unit  * amount,
            hydration: hydration_per_unit * amount
          }
        end
      end
    end
  end
end
