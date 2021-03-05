module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_tear_writing(params)
            emitter = params[:emitter]
            target  = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You tear ", "#{emitter.short_desc} tears ")

            text << "#{target.short_desc} into tiny pieces."

            tx(text)
          end
        end
      end
    end
  end
end
