module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_hear_shout(params)
            emitter   = params[:emitter]
            speech    = params[:speech]
            direction = params[:direction]

            voice_gender = " #{voice(emitter.physical_attr_controller.gender)}"

            text = "You hear a#{voice_gender} from #{opposite_as_from(direction)} shout in #{guess_spoken_language(emitter)}:\n  \"#{garble_speech(speech, emitter)}\"\n"

            tx(text)
          end
        end
      end
    end
  end
end
