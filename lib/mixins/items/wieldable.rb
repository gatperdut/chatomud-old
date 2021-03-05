require "mixins/slots/definition"

module ChatoMud
  module Mixins
    module Items
      module Wieldable
        include Slots::Definition

        def is_wielded?
          wield_slots.include?(slot)
        end
      end
    end
  end
end
