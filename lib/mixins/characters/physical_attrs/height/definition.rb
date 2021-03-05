module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Height
          module Definition
            def all_height_categories
              [
                :diminute,
                :very_short,
                :short,
                :average_height,
                :tall,
                :towering,
                :colossal
              ]
            end
          end
        end
      end
    end
  end
end
