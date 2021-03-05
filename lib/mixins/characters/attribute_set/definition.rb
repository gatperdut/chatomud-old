module ChatoMud
  module Mixins
    module Characters
      module AttributeSet
        module Definition
          def all_attributes
            [
              :str,
              :con,
              :agi,
              :dex,
              :int,
              :wil,
              :pow
            ]
          end
        end
      end
    end
  end
end
