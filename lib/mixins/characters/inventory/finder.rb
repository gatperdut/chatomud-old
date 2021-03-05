module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module Finder
          def find_held_item_controller(kword)
            find_item_controller_internal(kword, held_item_controllers)
          end

          def find_wielded_item_controller(kword)
            find_item_controller_internal(kword, wielded_item_controllers)
          end

          def find_carried_item_controller(kword)
            find_item_controller_internal(kword, carried_item_controllers)
          end

          def find_worn_item_controller(kword)
            find_item_controller_internal(kword, worn_item_controllers)
          end

          def find_worn_or_wielded_item_controller(kword)
            find_item_controller_internal(kword, worn_or_wielded_item_controllers)
          end

          def find_sheath_item_controller(kword)
            find_item_controller_internal(kword, sheath_item_controllers(:any))
          end

          def find_sheathed_item_controller(kword)
            find_item_controller_internal(kword, melee_weapon_controllers(:in_sheaths))
          end

          def find_sheathable_item_controller(kword)
            find_item_controller_internal(kword, melee_weapon_controllers(:wielded))
          end

          def find_any_item_controller(kword)
            find_item_controller_internal(kword, item_controllers_ordered_by_slot)
          end

          def lockers_for(lock_controller)
            lock_controller.lockers & held_item_controllers.map(&:model)
          end
        end
      end
    end
  end
end
