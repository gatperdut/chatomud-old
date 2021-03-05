module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module Carrier
          def carried_item_controllers
            held_item_controllers + wielded_item_controllers
          end

          def is_carrying_anything?
            carried_item_controllers.any?
          end

          def drop_carried_items
            carried_item_controllers.each do |item_controller|
              if item_controller.is_weapon? && item_controller.weapon_stat_controller.is_ranged? && !item_controller.weapon_stat_controller.ranged_stat_controller.can_remain_loaded? && item_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
                @owner_controller.room_controller.inventory_controller.accept_item(item_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.loaded_missile_controller, true)
              end
              @owner_controller.room_controller.inventory_controller.accept_item(item_controller, true)
            end
          end
        end
      end
    end
  end
end
