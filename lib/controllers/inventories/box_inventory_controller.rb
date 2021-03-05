require "controllers/inventories/inventory_controller"
require "controllers/inventories/lid_controller"

module ChatoMud
  module Controllers
    module Inventories
      class BoxInventoryController < InventoryController
        attr_reader :lid_controller

        def initialize(server, owner_controller, inventory)
          super(server, owner_controller, inventory)

          @lid_controller = @inventory.lid ? LidController.new(@inventory.lid) : nil
        end

        def is_closable?
          !!@lid_controller
        end

        def accept_item(item_controller, remove_from_parent_inventory_controller)
          item_controller.set_slot("void", false)
          super(item_controller, remove_from_parent_inventory_controller)
        end

        def list_inventory(desc_type)
          @item_controllers.map(&desc_type).join("\n")
        end

        def model
          @inventory
        end
      end
    end
  end
end
