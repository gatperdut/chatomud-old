module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_dusk(_params)
            tx("The light from Anor dims as it starts disappering under the western horizon.")
          end
        end
      end
    end
  end
end
