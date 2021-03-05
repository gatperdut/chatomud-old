module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_empty_on_ground(params)
            emitter = params[:emitter]
            target = params[:target]

            text = interpolate_me_other(emitter, "You empty", "#{emitter.short_desc} empties")

            text << " the contents of #{target.short_desc} on the ground:\n#{target.inventory_controller.list_inventory(:short_desc)}"

            tx(text)
          end
        end
      end
    end
  end
end
