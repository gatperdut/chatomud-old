module ChatoMud
  module Mixins
    module Aasm
      module Definition
        def all_aasm_codes
          [
            :aggro,
            :wanderer
          ]
        end
      end
    end
  end
end
