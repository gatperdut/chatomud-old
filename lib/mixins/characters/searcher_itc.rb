module ChatoMud
  module Mixins
    module Characters
      # Move within 'searching' folder along with 'searcher'
      module SearcherItc
        def search_ingredient_controllers(craft_ingredient)
          item_templates = []
          craft_ingredient.item_template_codes.each do |item_template_code|
            item_templates << ItemTemplate.find_by_code(item_template_code)
          end

          results = send("search_ingredient_controllers_#{craft_ingredient.location}", craft_ingredient, item_templates)

          {
            craft_ingredient: craft_ingredient,
            item_templates:   item_templates,
            results:          results
          }
        end

        def search_ingredient_controllers_in_room(craft_ingredient, item_templates)
          @room_controller.inventory_controller.find_ingredient_controllers(craft_ingredient, item_templates, nil)
        end

        def search_ingredient_controllers_held(craft_ingredient, item_templates)
          @inventory_controller.find_held_ingredient_controllers(craft_ingredient, item_templates)
        end
      end
    end
  end
end
