module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module MeleeWeaponWielder
          # :held, :wielded, :held_or_wielded, :in_sheaths
          def melee_weapon_controllers(where)
            send("melee_weapon_controllers_#{where}")
          end

          def wielding_melee_weapon?
            melee_weapon_controllers_wielded.count.positive?
          end

          private

          def melee_weapon_controllers_held
            held_item_controllers.select do |held_item_controller|
              held_item_controller.is_weapon? && held_item_controller.weapon_stat_controller.is_melee?
            end
          end

          def melee_weapon_controllers_wielded
            wielded_item_controllers.select do |held_item_controller|
              held_item_controller.is_weapon? && held_item_controller.weapon_stat_controller.is_melee?
            end
          end

          def melee_weapon_controllers_held_or_wielded
            melee_weapon_controllers_held + melee_weapon_controllers_wielded
          end

          def melee_weapon_controllers_in_sheaths
            result = []
            sheath_item_controllers(:full).select do |item_controller|
              result << item_controller.inventory_controller.sheathed_weapon_controller
            end
            result
          end
        end
      end
    end
  end
end
