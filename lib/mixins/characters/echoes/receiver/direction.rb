module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_direction(params)
            emitter   = params[:emitter]
            direction = params[:direction]
            emote     = params[:emote]
            fleeing   = params[:fleeing]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You start ", "#{emitter.short_desc} starts ")

            text << "#{emitter.choice_controller.pace}ing "

            text << "#{direction}ward"

            if fleeing
              text << ", managing to escape."
            else
              if emote
                text << ", #{interpolate_refs(emote, emitter, false)}."
              else
                text << "."
              end

              tx(text)
            end
          end
        end
      end
    end
  end
end
