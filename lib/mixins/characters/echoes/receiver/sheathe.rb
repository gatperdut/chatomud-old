module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_sheathe(params)
            emitter = params[:emitter]
            target = params[:target]
            sheath = params[:sheath]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You sheathe ", "#{emitter.short_desc} sheathes ")

            text << "#{target.short_desc} in #{sheath.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
