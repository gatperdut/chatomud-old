module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_wear(params)
            emitter = params[:emitter]
            target  = params[:target]
            slot    = params[:slot]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You wear ", "#{emitter.short_desc} wears ")

            text << "#{target.short_desc} "
            text << interpolate_me_other(emitter, "#{slot_description(slot, :personal)}", "#{slot_description(slot, emitter.physical_attr_controller.gender)}")
            text << "."
            tx(text)
          end
        end
      end
    end
  end
end
