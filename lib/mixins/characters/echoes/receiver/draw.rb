module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_draw(params)
            emitter = params[:emitter]
            target = params[:target]
            sheath = params[:sheath]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You draw ", "#{emitter.short_desc} draws ")

            text << "#{target.short_desc} from #{sheath.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
