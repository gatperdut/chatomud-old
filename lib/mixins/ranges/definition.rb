module ChatoMud
  module Mixins
    module Ranges
      module Definition
        def all_ranges
          [
            :point_blank,
            :short_range,
            :medium_range,
            :long_range
          ]
        end
      end
    end
  end
end
