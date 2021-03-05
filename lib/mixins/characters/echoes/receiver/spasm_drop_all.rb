module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_spasm_drop_all(params)
            emitter = params[:emitter]
            items   = params[:items]

            return unless can_see_action?(emitter)

            items_short_desc = items[0].short_desc

            items_short_desc << " and #{items[1].short_desc}" if items.count > 1

            slip = items.count > 1 ? "slip" : "slips"

            land = items.count > 1 ? "land" : "lands"

            text = interpolate_me_other(emitter, "#{items_short_desc} #{slip} from your hands and #{land} on the ground.", "#{items_short_desc} #{slip} from the hands of #{emitter.short_desc} and #{land} on the ground.")

            tx(text)
          end
        end
      end
    end
  end
end
