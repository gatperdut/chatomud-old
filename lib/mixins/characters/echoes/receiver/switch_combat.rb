module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_switch_combat(params)
            emitter = params[:emitter]
            new_target = params[:new_target]

            text = interpolate_me_other(emitter, "You shift ", "#{emitter.short_desc} shifts ")
            text << "#{interpolate_possessive(emitter)} attention to "
            text << interpolate_me_others(emitter, new_target, "#{new_target.short_desc}.", "you!", "#{new_target.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
