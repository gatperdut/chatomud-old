module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Weight
          module Definition
            def all_weight_categories
              [
                :thin,
                :slight,
                :slender,
                :average_weight,
                :stocky,
                :heavy,
                :huge
              ]
            end
          end
        end
      end
    end
  end
end
