module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_stop_combat(params)
            emitter = params[:emitter]
            target = params[:target]

            text = interpolate_me_others(emitter, target, "You stop fighting #{target.short_desc}.", "#{emitter.short_desc} motions for a truce.", "#{emitter.short_desc} stops fighting #{target.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
