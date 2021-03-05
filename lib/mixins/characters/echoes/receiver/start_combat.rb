module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_start_combat(params)
            emitter = params[:emitter]
            target = params[:target]

            text = interpolate_me_others(emitter, target, "You engage #{target.short_desc} in combat.", "#{emitter.short_desc} engages you in combat!", "#{emitter.short_desc} engages #{target.short_desc} in combat.")

            tx(text)
          end
        end
      end
    end
  end
end
