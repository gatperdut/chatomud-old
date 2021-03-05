module ChatoMud
  module Mixins
    module Ranges
      module Utils
        def range_modifier(ranges_suitability, range)
          index = ranges_suitability.index_of(range)

          raise "range not found in ranges_suitability" unless index

          [5, 0, -10, -25][index]
        end
      end
    end
  end
end
