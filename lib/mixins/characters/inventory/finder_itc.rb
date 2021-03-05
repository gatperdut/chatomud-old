module ChatoMud
  module Mixins
    module Characters
      module Inventory
        # itc = Item Controllers Subset.
        module FinderItc
          def find_held_ingredient_controllers(craft_ingredient, item_templates)
            find_ingredient_controllers(craft_ingredient, item_templates, held_item_controllers)
          end
        end
      end
    end
  end
end
