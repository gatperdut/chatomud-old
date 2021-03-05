require "controllers/base_controller"

require "mixins/describable/furniture"
require "mixins/furnitures/accommodator"

module ChatoMud
  module Controllers
    module Furnitures
      class FurnitureController < BaseController
        include Mixins::Describable::Furniture
        include Mixins::Furnitures::Accommodator

        attr_reader :room_controller
        attr_reader :inventory_controller

        def initialize(server, furniture, room_controller)
          super(server)
          @furniture = furniture
          @room_controller = room_controller
          @position_controllers = []
          if @furniture.inventory
            @inventory_controller = Inventories::BoxInventoryController.new(@server, self, @furniture.inventory)
          else
            @inventory_controller = nil
          end
          @server.items_handler.add_item_controller(self)
          @room_controller.add_furniture_controller(self)
        end

        def is_container?
          !!@inventory_controller
        end

        def is_light_source?
          false
        end

        def model
          @furniture
        end

        def id
          model.id
        end
      end
    end
  end
end
