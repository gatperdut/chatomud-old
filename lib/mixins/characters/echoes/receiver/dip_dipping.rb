module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_dip_dipping(params)
            emitter = params[:emitter]
            target  = params[:target]
            source  = params[:source]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You dip ", "#{emitter.short_desc} dips ")

            text << "#{target.short_desc} into #{source.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
