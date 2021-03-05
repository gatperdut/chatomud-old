module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module WeaponWielder
          def wield(item_controller)
            slot = get_wield_slot(item_controller)
            item_controller.set_slot(slot, true)
          end

          def wielded_item_controllers
            item_controllers_ordered_by_slot.reject do |item_controller|
              !item_controller.is_in_slot?(:wlhand) && !item_controller.is_in_slot?(:wrhand) && !item_controller.is_in_slot?(:w2hands)
            end
          end

          def get_wield_slot(item_controller)
            return :w2hands if item_controller.weapon_stat_controller.is_two_handed?

            return :wrhand if find_item_controller_by_slot(:rhand) == item_controller
            return :wlhand if find_item_controller_by_slot(:lhand) == item_controller

            return :wrhand unless find_item_controller_by_slot(:rhand) || find_item_controller_by_slot(:wrhand)
            return :wlhand unless find_item_controller_by_slot(:lhand) || find_item_controller_by_slot(:wlhand)
          end

          def can_wield?(item_controller)
            return can_wield_two_handed?(item_controller) if item_controller.weapon_stat_controller.is_two_handed?

            can_wield_left_hand?(item_controller) || can_wield_right_hand?(item_controller)
          end

          def can_wield_two_handed?(item_controller)
            carried = carried_item_controllers
            carried.count.zero? || (carried.count == 1 && carried[0] == item_controller)
          end

          def can_wield_right_hand?(item_controller)
            return false if find_item_controller_by_slot(:w2hands)
            return false if find_item_controller_by_slot(:wrhand)

            held_right_hand = find_item_controller_by_slot(:rhand)
            !held_right_hand || held_right_hand == item_controller
          end

          def can_wield_left_hand?(item_controller)
            return false if find_item_controller_by_slot(:w2hands)
            return false if find_item_controller_by_slot(:wlhand)

            held_left_hand = find_item_controller_by_slot(:lhand)
            !held_left_hand || held_left_hand == item_controller
          end

          def is_dual_wielding?
            melee_weapon_controllers(:wielded).count > 1
          end

          def is_wielding_two_handed?
            !find_item_controller_by_slot(:w2hands).nil?
          end
        end
      end
    end
  end
end
