module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_give_failed(params)
            emitter  = params[:emitter]
            receiver = params[:receiver]
            target   = params[:target]

            text = interpolate_me_others(emitter, receiver, "#{receiver.short_desc} has #{interpolate_possessive(receiver)} hands full.", "#{emitter.short_desc} just tried to give you #{target.short_desc}, but your hands are full.", "#{emitter.short_desc} tries to give #{target.short_desc} to #{receiver.short_desc}, but #{interpolate_possessive(receiver)} hands are full.")

            tx(text)
          end
        end
      end
    end
  end
end
