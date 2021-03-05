module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_fall_unconscious(params)
            emitter = params[:emitter]

            text_self = "Your body gives up and you fall"
            text_others = "#{emitter.short_desc} has been rendered unconscious"

            if position_controller.is_accommodated?
              text_self << " off #{position_controller.furniture_controller.short_desc}, unconscious."
              text_others << ", falling off #{position_controller.furniture_controller.short_desc}."
            else
              text_self << " unconscious."
              text_others << "."
            end

            text = interpolate_me_other(emitter, text_self, text_others)

            tx(text)
          end
        end
      end
    end
  end
end
