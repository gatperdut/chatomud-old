module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_fuel(params)
            emitter = params[:emitter]
            target  = params[:target]
            source  = params[:source]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You fuel ", "#{emitter.short_desc} fuels ")

            text << "#{target.short_desc} with #{source.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
