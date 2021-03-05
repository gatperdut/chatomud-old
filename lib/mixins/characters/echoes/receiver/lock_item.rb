module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_lock_item(params)
            emitter = params[:emitter]
            target  = params[:target]
            with    = params[:with]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You lock", "#{emitter.short_desc} locks")

            text << " #{target.short_desc} with #{with.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
