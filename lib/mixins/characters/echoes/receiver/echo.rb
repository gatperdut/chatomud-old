module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_echo(params)
            speech = params[:speech]

            text = "\n#{speech}\n"

            tx(text)
          end
        end
      end
    end
  end
end
