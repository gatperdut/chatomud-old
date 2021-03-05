require "controllers/inventories/box_inventory_controller"

module ChatoMud
  module Controllers
    module Inventories
      class SheathInventoryController < BoxInventoryController
        def sheathed_weapon_controller
          @item_controllers[0]
        end

        def list_sheathed_weapon
          sheathed_weapon_controller.weapon_stat_controller.melee_stat_controller.sheathed_desc
        end
      end
    end
  end
end
