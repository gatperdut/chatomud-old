module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_unlock_door(params)
            emitter = params[:emitter]
            target  = params[:target]
            with    = params[:with]

            text = interpolate_me_other(emitter, "You unlock", "#{emitter.short_desc} unlocks")

            text << " #{target.long_desc} with #{with.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
