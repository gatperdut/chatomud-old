module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module Holder
          def held_item_controllers
            item_controllers_ordered_by_slot.reject do |item_controller|
              !item_controller.is_in_slot?(:lhand) && !item_controller.is_in_slot?(:rhand)
            end
          end

          def get_hold_slot(item_controller)
            return :rhand if can_hold_right_hand?(item_controller)
            return :lhand if can_hold_left_hand?(item_controller)

            nil
          end

          def can_hold?(item_controller)
            get_hold_slot(item_controller)
          end

          def can_hold_right_hand?(item_controller)
            wielded_two_handed = find_item_controller_by_slot(:w2hands)
            if wielded_two_handed
              return wielded_two_handed == item_controller
            end

            return false if find_item_controller_by_slot(:rhand)

            wielded_right_hand = find_item_controller_by_slot(:wrhand)
            !wielded_right_hand || wielded_right_hand == item_controller
          end

          def can_hold_left_hand?(item_controller)
            wielded_two_handed = find_item_controller_by_slot(:w2hands)
            if wielded_two_handed
              return wielded_two_handed == item_controller
            end

            return false if find_item_controller_by_slot(:lhand)

            wielded_left_hand = find_item_controller_by_slot(:wlhand)
            !wielded_left_hand || wielded_left_hand == item_controller
          end
        end
      end
    end
  end
end
