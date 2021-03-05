module ChatoMud
  module Mixins
    module Characters
      module Encumbrance
        module Utils
          def encumbrance_description(encumbrance_level)
            case encumbrance_level
              when 0
                "unencumbered"
              when 1..2
                "lightly encumbered"
              when 3..4
                "moderately encumbered"
              when 5..6
                "heavily encumbered"
              when 7..Float::INFINITY
                "critically encumbered"
              else
                raise "Unknown encumbrance level when determining encumbrance description."
            end
          end
        end
      end
    end
  end
end
