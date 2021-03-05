module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_simple_say(params)
            emitter = params[:emitter]
            speech  = params[:speech]

            text = nil
            if params[:type] == :say
              text = interpolate_me_other(emitter, "You say in #{guess_spoken_language(self)}", "#{emitter.short_desc} says in #{guess_spoken_language(emitter)}")
            else
              text = interpolate_me_other(emitter, "You shout in #{guess_spoken_language(self)}", "#{emitter.short_desc} shouts in #{guess_spoken_language(emitter)}")
            end

            text << ":\n  \"#{garble_speech(speech, emitter)}\""

            tx(text)
          end
        end
      end
    end
  end
end
