require "mixins/actions/helpers/items"

module ChatoMud
  module Mixins
    module Crafts
      module Usage
        include Mixins::Actions::Helpers::Items

        # @ingredients =
        # {
        #   craft_ingredient: craft_ingredient,
        #   item_templates:   item_templates,
        #   results:          results
        # }
        def handle_usage(craft_step)
          occurrence_indexes = craft_step.find_occurrence_indexes(:echo_first)

          occurrence_indexes.each_with_index do |occurrence_index, index|
            ingredient = @ingredients[index - 1]

            send("handle_usage_type_#{ingredient[:craft_ingredient].usage_type}", ingredient)
          end
        end

        def handle_usage_type_gone(ingredient)
          goal = ingredient[:craft_ingredient].how_many

          total                 = 0
          sub_total             = nil
          item_controller_index = 0
          item_controller       = nil

          while total < goal
            item_controller = ingredient[:results][:item_controllers][item_controller_index]
            if item_controller.is_stackable?
              sub_total = item_controller.stack_controller.current
              if total + sub_total >= goal
                item_controller.stack_controller.consume(goal - total)
              else
                item_controller.junk(true)
              end
            else
              item_controller.junk(true)
              sub_total = 1
            end
            total += sub_total
            item_controller_index += 1
          end
        end

        def handle_usage_type_reusable(ingredient)
        end
      end
    end
  end
end
