module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_follow_stop(params)
            emitter = params[:emitter]

            target = emitter.group_controller.following

            text = interpolate_me_others(emitter, target, "You stop following #{target.short_desc}.", "#{emitter.short_desc} stops following you.", "#{emitter.short_desc} stops following #{target.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
