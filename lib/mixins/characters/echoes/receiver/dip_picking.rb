module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_dip_picking(params)
            emitter = params[:emitter]
            target  = params[:target]
            spawned = params[:spawned]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You take ", "#{emitter.short_desc} takes ")

            text << "#{spawned.short_desc} from #{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
