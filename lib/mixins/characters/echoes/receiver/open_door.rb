module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_open_door(params)
            emitter   = params[:emitter]
            target    = params[:target]
            direction = params[:direction]

            text = interpolate_me_other(emitter, "You open ", "#{emitter.short_desc} opens ")

            text << "#{target.long_desc} leading #{direction}wards."

            tx(text)
          end
        end
      end
    end
  end
end
