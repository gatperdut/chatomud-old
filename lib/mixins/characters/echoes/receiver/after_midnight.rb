module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_after_midnight(_params)
            tx("Ithil rises with stately grace across the sky.")
          end
        end
      end
    end
  end
end
