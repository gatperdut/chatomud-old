module ChatoMud
  module Mixins
    module Characters
      module AttributeSet
        module Utils
          module Agility
            def agility_travel_time_multiplier
              1 - attribute_bonus(:agi).clamp(-10, 10) / 20.0
            end
          end
        end
      end
    end
  end
end
