module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_flee_start(params)
            emitter = params[:emitter]

            text = interpolate_me_other(emitter, "You start looking for a way to escape!", "#{emitter.short_desc} starts looking for a way to escape!")

            tx(text)
          end
        end
      end
    end
  end
end
