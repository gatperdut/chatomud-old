require "mixins/slots/definition"

module ChatoMud
  module Mixins
    module Items
      module Wearable
        include Mixins::Slots::Definition

        def is_wearable?
          model.possible_slots.present?
        end

        def is_being_worn?
          worn_slots.include?(slot)
        end

        def first_slot
          model.possible_slots[0]
        end

        def is_wearable_in?(slot)
          model.possible_slots.include?(slot)
        end

        def is_in_slot?(slot)
          model.slot.to_sym == slot
        end

        def possible_slots
          model.possible_slots
        end

        def set_slot(slot, do_save)
          model.slot = slot
          model.save! if do_save
        end
      end
    end
  end
end
