require "mixins/slots/definition"

module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module Wearer
          extend Slots::Definition

          def worn_item_controllers
            item_controllers_ordered_by_slot.reject do |item_controller|
              item_controller.is_in_slot?(:lhand) || item_controller.is_in_slot?(:rhand) || item_controller.is_in_slot?(:wlhand) || item_controller.is_in_slot?(:wrhand) || item_controller.is_in_slot?(:w2hands)
            end
          end

          def armor_item_controllers
            worn_item_controllers.select(&:is_armor?)
          end

          def worn_or_wielded_item_controllers
            worn_item_controllers + wielded_item_controllers
          end

          def is_slot_free?(slot)
            find_item_controller_by_slot(slot).nil?
          end

          def find_item_controller_by_slot(slot)
            @item_controllers.each do |item_controller|
              return item_controller if item_controller.is_in_slot?(slot)
            end
            nil
          end

          def item_controllers_ordered_by_slot
            item_controllers = []
            self.class.all_slots.each do |slot|
              item_controller = find_item_controller_by_slot(slot)
              item_controllers << item_controller if item_controller
            end
            item_controllers
          end
        end
      end
    end
  end
end
