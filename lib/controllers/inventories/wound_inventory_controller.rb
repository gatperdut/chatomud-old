require "controllers/inventories/box_inventory_controller"

module ChatoMud
  module Controllers
    module Inventories
      class WoundInventoryController < BoxInventoryController
        def lodged_missile_controller
          @item_controllers[0]
        end

        def list_lodged_missile
          lodged_missile_controller.short_desc
        end
      end
    end
  end
end
