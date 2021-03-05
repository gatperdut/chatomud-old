module ChatoMud
  module Mixins
    module Inventories
      module LightSourcesContainer
        def find_light_source_controllers
          @item_controllers.select(&:is_light_source?)
        end
      end
    end
  end
end
