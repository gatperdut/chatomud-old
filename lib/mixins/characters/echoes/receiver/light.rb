module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_light(params)
            emitter = params[:emitter]
            target  = params[:target]
            off     = params[:off]

            if off
              text  = interpolate_me_other(emitter, "You put ", "#{emitter.short_desc} puts ")
            else
              text  = interpolate_me_other(emitter, "You light ", "#{emitter.short_desc} lights ")
            end

            text << "#{target.short_desc}"

            if off
              text << " out."
            else
              text << "."
            end

            tx(text)
          end
        end
      end
    end
  end
end
