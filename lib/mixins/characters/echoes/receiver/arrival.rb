module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_arrival(params)
            emitter   = params[:emitter]
            from      = params[:from]
            fleeing   = params[:fleeing]

            return if emitter == self

            return unless room_controller.can_be_seen_by_character?(self)

            # Emote needs to be considered here.

            text = "#{emitter.short_desc} comes #{emitter.choice_controller.pace}ing from #{from}"

            text << (fleeing ? ", escaping from something." : ".")

            tx(text)
          end
        end
      end
    end
  end
end
