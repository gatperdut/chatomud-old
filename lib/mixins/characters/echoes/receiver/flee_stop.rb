module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_flee_stop(params)
            emitter = params[:emitter]
            reason  = params[:reason]

            text_self   = reason == :requested ? "You stop looking for a way to escape." : "Your last opponent is down, you stop fleeing."

            text_others = reason == :requested ? "#{emitter.short_desc} stops trying to escape." : "The last opponent of #{emitter.short_desc} is down, #{personal(emitter.physical_attr_controller.gender)} stops fleeing}"

            text = interpolate_me_other(emitter, text_self, text_others)

            tx(text)
          end
        end
      end
    end
  end
end
