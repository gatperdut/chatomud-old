module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_flee_outcome(params)
            emitter = params[:emitter]
            outcome = params[:outcome]

            direction = "#{emitter.combat_controller.flee_direction}ward".red

            text_self   = outcome == :success ? "\nYou FLEE #{direction}!\n" : "\nYou continue looking for an escape route . . .\n"

            text_others = outcome == :success ? "\n#{emitter.short_desc} FLEES #{direction}!\n" : "\n#{emitter.short_desc} continues looking for an escape route . . .\n"

            text = interpolate_me_other(emitter, text_self, text_others)

            tx(text)
          end
        end
      end
    end
  end
end
