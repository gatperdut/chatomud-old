require "controllers/inventories/box_inventory_controller"

module ChatoMud
  module Controllers
    module Inventories
      class QuiverInventoryController < BoxInventoryController
        def missile_controllers(missile_type)
          @item_controllers.select do |item_controller|
            item_controller.missile_stat_controller.is_missile_type?(missile_type)
          end
        end

        def list_missile_controllers
          @item_controllers.map(&:missile_stat_controller).map(&:stowed_desc).uniq.to_sentence
        end
      end
    end
  end
end
