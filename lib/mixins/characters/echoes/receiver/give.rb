module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_give(params)
            emitter  = params[:emitter]
            receiver = params[:receiver]
            target   = params[:target]

            text = interpolate_me_others(emitter, receiver, "You give #{target.short_desc} to #{receiver.short_desc}.", "#{emitter.short_desc} gives you #{target.short_desc}", "#{emitter.short_desc} gives #{target.short_desc} to #{receiver.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
