module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_lock_door(params)
            emitter = params[:emitter]
            target  = params[:target]
            with    = params[:with]

            text = interpolate_me_other(emitter, "You lock", "#{emitter.short_desc} locks")

            text << " #{target.long_desc} with #{with.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
