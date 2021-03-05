module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_fill(params)
            emitter = params[:emitter]
            target  = params[:target]
            source  = params[:source]
            amount  = params[:amount]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You fill ", "#{emitter.short_desc} fills ")

            text << "#{target.short_desc} with #{amount.fluid_colorized} from #{source.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
