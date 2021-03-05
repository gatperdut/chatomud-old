module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_emoted_tell(params)
            target  = params[:target]
            emitter = params[:emitter]
            emote   = params[:emote]
            speech  = params[:speech]

            text = interpolate_me_others(emitter, target, "You tell #{target.short_desc} in #{guess_spoken_language(self)}, ", "#{emitter.short_desc} tells you in #{guess_spoken_language(emitter)}, ", "#{emitter.short_desc} tells #{target.short_desc} in #{guess_spoken_language(emitter)}, ")

            return if (text << interpolate_refs(emote, emitter, false)).nil?

            text << ",\n  \"#{garble_speech(speech, emitter)}\""

            tx(text)
          end
        end
      end
    end
  end
end
