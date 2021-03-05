require "mixins/fluids/utils"

module ChatoMud
  module Mixins
    module Items
      module Weightable
        include Mixins::Fluids::Utils

        def is_dead_weight?
          return false if is_being_worn? && !is_container?

          !is_being_worn? || !is_armor?
        end

        def weight
          if is_edible?
            base_weight = edible_weight
          elsif is_stackable?
            base_weight = stack_weight(true)
          else
            base_weight = model.weight
          end

          added_weight = 0

          added_weight += inventory_weight if is_container?

          added_weight += fillable_weight  if is_fillable?

          base_weight + added_weight
        end

        private

        def edible_weight
          stack_weight = stack_weight(false)

          partial_weight = (@food_controller.percentage * model.weight).round

          stack_weight + partial_weight
        end

        def stack_weight(include_last)
          modifier = include_last ? 0 : 1

          (@stack_controller.current - modifier) * model.weight
        end

        def fillable_weight
          @fluid_controller.current * fluid_weight_per_unit(@fluid_controller.fluid)
        end

        def inventory_weight
          @inventory_controller.borne_weight
        end
      end
    end
  end
end
