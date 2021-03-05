module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_regain_consciousness(params)
            emitter = params[:emitter]

            text = interpolate_me_other(emitter, "You regain consciousness.", "#{emitter.short_desc} regains consciousness.")

            tx(text)
          end
        end
      end
    end
  end
end
