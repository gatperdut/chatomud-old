module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_drop_all(params)
            emitter = params[:emitter]
            items  = params[:items]

            return unless can_see_action?(emitter)

            items_short_desc = items[0].short_desc

            items_short_desc << " and #{items[1].short_desc}" if items.count > 1

            text = interpolate_me_other(emitter, "You drop #{items_short_desc}.", "#{emitter.short_desc} drops #{items_short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
