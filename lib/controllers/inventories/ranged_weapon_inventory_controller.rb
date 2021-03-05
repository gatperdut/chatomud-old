require "controllers/inventories/box_inventory_controller"

module ChatoMud
  module Controllers
    module Inventories
      class RangedWeaponInventoryController < BoxInventoryController
        def loaded_missile_controller
          @item_controllers[0]
        end

        def is_loaded?
          !!loaded_missile_controller
        end

        def list_loaded_missile
          loaded_missile_controller.short_desc
        end
      end
    end
  end
end
