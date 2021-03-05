module ChatoMud
  module Mixins
    module Inventories
      module BoardsContainer
        def find_board_controllers
          @item_controllers.select(&:is_board?)
        end
      end
    end
  end
end
