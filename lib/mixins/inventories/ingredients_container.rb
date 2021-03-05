module ChatoMud
  module Mixins
    module Inventories
      module IngredientsContainer
        def find_ingredient_controllers(craft_ingredient, item_templates, item_controllers_subset)
          item_controllers_subset ||= @item_controllers

          goal = craft_ingredient.how_many.present? ? craft_ingredient.how_many : 1

          goal_met         = false
          total            = 0
          item_controllers = []

          item_templates.each do |item_template|
            goal_met           = false
            total              = 0
            item_controllers_subset.each do |item_controller|
              next unless (item_template.id == item_controller.item_template_id) && !item_controller.in_use

              if item_controller.is_stackable?
                total += item_controller.stack_controller.current
              else
                total += 1
              end
              goal_met = total >= goal
              item_controllers << item_controller
              break if goal_met
            end
            break if goal_met
          end

          {
            goal_met:         goal_met,
            item_controllers: item_controllers
          }
        end
      end
    end
  end
end
