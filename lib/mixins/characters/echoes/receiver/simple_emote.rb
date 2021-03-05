module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_simple_emote(params)
            emitter = params[:emitter]
            emote   = params[:emote]

            text = interpolate_refs(emote, emitter, true)
            return if text.nil?

            tx(text)
          end
        end
      end
    end
  end
end
