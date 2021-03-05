module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_empty_into_another(params)
            emitter     = params[:emitter]
            target      = params[:target]
            destination = params[:destination]

            text = interpolate_me_other(emitter, "You empty", "#{emitter.short_desc} empties")

            text << " the contents of #{target.short_desc} into #{destination.short_desc}:\n#{target.inventory_controller.list_inventory(:short_desc)}"

            tx(text)
          end
        end
      end
    end
  end
end
