module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module RangedWeaponWielder
          # where [:held, :wielded, :held_or_wielded]
          # loaded [true, false, :indifferent]
          def ranged_weapon_controllers(where, loaded)
            send("ranged_weapon_controllers_#{where}", loaded)
          end

          private

          def ranged_weapon_controllers_held(loaded)
            held_item_controllers.select do |item_controller|
              valid = item_controller.is_weapon? && item_controller.weapon_stat_controller.is_ranged?
              valid && matches_loaded_preference(item_controller, loaded)
            end
          end

          def ranged_weapon_controllers_wielded(loaded)
            wielded_item_controllers.select do |item_controller|
              valid = item_controller.is_weapon? && item_controller.weapon_stat_controller.is_ranged?
              valid && matches_loaded_preference(item_controller, loaded)
            end
          end

          def ranged_weapon_controllers_held_or_wielded(loaded)
            ranged_weapon_controllers_held(loaded) + ranged_weapon_controllers_wielded(loaded)
          end

          def matches_loaded_preference(ranged_weapon_controller, loaded)
            return true if loaded == :indifferent

            ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded? == loaded
          end
        end
      end
    end
  end
end
