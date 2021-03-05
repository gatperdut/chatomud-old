module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_remove(params)
            emitter = params[:emitter]
            target  = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You stop using ", "#{emitter.short_desc} stops using ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
