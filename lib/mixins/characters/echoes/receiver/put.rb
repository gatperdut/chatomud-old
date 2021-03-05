module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_put(params)
            emitter     = params[:emitter]
            target      = params[:target]
            destination = params[:destination]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You put ", "#{emitter.short_desc} puts ")

            text << "#{target.short_desc} in #{destination.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
