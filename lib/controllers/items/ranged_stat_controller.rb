require "controllers/base_controller"
require "controllers/inventories/ranged_weapon_inventory_controller"

module ChatoMud
  module Controllers
    module Items
      class RangedStatController < BaseController
        attr_reader :inventory_controller

        def initialize(server, weapon_stat_controller, ranged_stat)
          super(server)
          @weapon_stat_controller = weapon_stat_controller
          @ranged_stat = ranged_stat

          @inventory_controller = Inventories::RangedWeaponInventoryController.new(@server, self, ranged_stat.inventory)
        end

        def missile_type
          @ranged_stat.missile_type
        end

        def can_remain_loaded?
          @ranged_stat.can_remain_loaded
        end
      end
    end
  end
end
