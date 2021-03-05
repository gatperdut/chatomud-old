module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_close_item(params)
            emitter   = params[:emitter]
            target    = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You close ", "#{emitter.short_desc} closes ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
