module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_wield(params)
            emitter = params[:emitter]
            target = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You wield ", "#{emitter.short_desc} wields ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
