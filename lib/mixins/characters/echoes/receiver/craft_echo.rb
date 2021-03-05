module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_craft_echo(params)
            emitter     = params[:emitter]
            text_self   = params[:text_self]
            text_others = params[:text_others]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, text_self, text_others)

            tx(text)
          end
        end
      end
    end
  end
end
