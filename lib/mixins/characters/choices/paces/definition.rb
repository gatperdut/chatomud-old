module ChatoMud
  module Mixins
    module Characters
      module Choices
        module Paces
          module Definition
            def all_paces
              [
                :crawl,
                :trudge,
                :walk,
                :jog,
                :sprint,
                :dash
              ]
            end
          end
        end
      end
    end
  end
end
