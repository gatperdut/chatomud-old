module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_midday(_params)
            tx("Anor rises with stately grace in the sky.")
          end
        end
      end
    end
  end
end
