module ChatoMud
  module Mixins
    module Crafts
      module Ingredients
        module Definition
          def all_craft_ingredient_locations
            [
              :in_room,
              :held
            ]
          end

          def all_craft_ingredient_usage_types
            [
              :gone,
              :reusable
            ]
          end
        end
      end
    end
  end
end
