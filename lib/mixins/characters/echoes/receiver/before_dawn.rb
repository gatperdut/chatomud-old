module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_before_dawn(_params)
            tx("A glow illuminates the eastern horizon.")
          end
        end
      end
    end
  end
end
