module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_junk(params)
            emitter = params[:emitter]
            target  = params[:target]

            text = interpolate_me_other(emitter, "You junk ", "#{emitter.short_desc} junks ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
