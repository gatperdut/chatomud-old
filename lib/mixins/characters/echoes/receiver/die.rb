module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_die(params)
            emitter = params[:emitter]

            text = interpolate_me_other(emitter, "\nOverwhelmed at last, darkness engulfs you.".red, "#{emitter.short_desc} expires with a ragged exhalation.")

            tx(text)
          end
        end
      end
    end
  end
end
