module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_follow_direct(params)
            emitter     = params[:emitter]
            target      = params[:target]

            text = interpolate_me_others(emitter, target, "You fall into stride with #{target.short_desc}.", "#{emitter.short_desc} falls into stride with you.", "#{emitter.short_desc} falls into stride with #{target.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
