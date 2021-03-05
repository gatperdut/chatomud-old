module ChatoMud
  module Mixins
    module Characters
      module Gifts
        module Definition
          def all_gifts
            racial_gifts + psionic_gifts
          end

          def racial_gifts
            [
              :infravision
            ]
          end

          def psionic_gifts
            [
              :psionic_reach
            ]
          end
        end
      end
    end
  end
end
