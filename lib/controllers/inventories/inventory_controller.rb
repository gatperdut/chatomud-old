require "mixins/inventories/ingredients_container"
require "mixins/inventories/light_sources_container"
require "mixins/inventories/boards_container"
require "mixins/inventories/weight_bearer"

require "controllers/items/item_controller"

module ChatoMud
  module Controllers
    module Inventories
      class InventoryController
        include Mixins::Inventories::IngredientsContainer
        include Mixins::Inventories::LightSourcesContainer
        include Mixins::Inventories::BoardsContainer
        include Mixins::Inventories::WeightBearer

        attr_reader :owner_controller

        def initialize(server, owner_controller, inventory)
          @server = server
          @owner_controller = owner_controller
          @inventory = inventory

          @item_controllers = []
          @inventory.items.each do |item|
            Items::ItemController.new(@server, item, self)
          end
        end

        def add_item_controller(item_controller)
          @item_controllers << item_controller
        end

        def remove_item_controller(item_controller)
          @item_controllers.delete(item_controller)
        end

        def accept_item(item_controller, remove_from_containing_inventory_controller)
          item_controller.dock_on(self, @inventory, remove_from_containing_inventory_controller)
        end

        def bye
          @item_controllers.each(&:bye)
          @item_controllers.clear
        end

        def junk_all
          @item_controllers.each do |item_controller|
            item_controller.junk(false)
          end
          @item_controllers.clear
        end

        def find_item_controller(kword)
          find_item_controller_internal(kword, nil)
        end

        def has_content?
          @item_controllers.size.positive?
        end

        def dump_items_into(container_controller)
          @item_controllers.each do |item_controller|
            container_controller.inventory_controller.accept_item(item_controller, false)
          end
          @inventory.items.clear
          @item_controllers.clear
        end

        def item_count
          @item_controllers.size
        end

        protected

        def find_item_controller_internal(kword, item_controllers_subset)
          word = kword[:word]
          index = kword[:index] ? kword[:index].to_i : 1

          item_controllers_subset ||= @item_controllers

          current_index = 0
          item_controllers_subset.each do |item_controller|
            if item_controller.matches_word(word)
              current_index += 1
              return item_controller if current_index == index
            end
          end
          nil
        end
      end
    end
  end
end
