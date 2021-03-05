module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_cease_aiming(params)
            emitter = params[:emitter]
            reason  = params[:reason]
            data    = params[:data]

            return unless can_see_action?(emitter)

            text_others = "#{emitter.short_desc} ceases aiming."

            text = ""
            case reason
              when :none
                text << "You cease aiming."
              when :moved
                text << "You lose sight of your quarry when it moves #{data[:direction]}ward"
                fleeing_text = data[:fleeing] ? ", escaping from combat." : "."
                text << fleeing_text
              when :dead
                text << "Your quarry has dropped dead, you cease aiming."
              when :unconscious
                text << "Your quarry has dropped unconscious, you cease aiming."
              when :quit
                text << "Your quarry is suddenly gone, you cease aiming."
              when :gone
                text << "Your quarry has vanished in a puff of smoke, you cease aiming."
              else
                raise "unknown reason for cease aiming echo"
            end

            result = interpolate_me_other(emitter, text, text_others)

            tx(result)
          end
        end
      end
    end
  end
end
