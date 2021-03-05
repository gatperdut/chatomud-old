module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_flee_change(params)
            emitter = params[:emitter]

            text = interpolate_me_other(emitter, "You abandon that hope, and start looking for different a way to escape!.", "#{emitter.short_desc} starts looking for a different way to escape!")

            tx(text)
          end
        end
      end
    end
  end
end
