module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_drop(params)
            emitter = params[:emitter]
            target  = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You drop ", "#{emitter.short_desc} drops ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
