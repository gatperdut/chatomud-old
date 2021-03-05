module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_turn_around(params)
            emitter = params[:emitter]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You turn around.", "#{emitter.short_desc} turns around.")

            tx(text)
          end
        end
      end
    end
  end
end
