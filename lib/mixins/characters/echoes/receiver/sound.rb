module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_sound(params)
            emitter     = params[:emitter]
            target      = params[:target]

            text = interpolate_me_other(emitter, target.horn_property_controller.action_echo_self, "#{emitter.short_desc} #{target.horn_property_controller.action_echo_others}")

            tx(text)
          end
        end
      end
    end
  end
end
