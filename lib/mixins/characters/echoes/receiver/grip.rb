module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_grip(params)
            emitter = params[:emitter]
            target = params[:target]
            grip = params[:grip]

            text = interpolate_me_other(emitter, "You switch to ", "#{emitter.short_desc} switches to ")

            case grip
              when :one_handed
                text << "a one-handed grip"
              when :two_handed
                text << "a two-handed grip"
            end

            text << " on #{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
