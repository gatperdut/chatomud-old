module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_title(params)
            emitter = params[:emitter]
            target  = params[:target]
            source  = params[:source]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You title ", "#{emitter.short_desc} titles ")

            text << "#{target.short_desc} with #{source.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
