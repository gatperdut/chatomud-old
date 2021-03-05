module ChatoMud
  module Mixins
    module Shield
      module Definition
        def all_variants
          [
            :wall,
            :full,
            :normal,
            :target
          ]
        end
      end
    end
  end
end
