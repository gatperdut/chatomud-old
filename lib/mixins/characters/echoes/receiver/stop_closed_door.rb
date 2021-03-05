module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_stop_closed_door(params)
            emitter = params[:emitter]
            door_controller = params[:door_controller]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You stop in front of", "#{emitter.short_desc} stops in front of")

            text << " #{door_controller.long_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
