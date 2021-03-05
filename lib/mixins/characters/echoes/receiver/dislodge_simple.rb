module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_dislodge_simple(params)
            emitter   = params[:emitter]
            body_part = params[:body_part]
            missile   = params[:missile]

            text = interpolate_me_other(emitter, "You dislodge ", "#{emitter.short_desc} dislodges ")

            text << "#{missile.short_desc} from "

            text << interpolate_me_other(emitter, "your #{simple_body_part_description(body_part)}.", "#{possessive(emitter.physical_attr_controller.gender)} #{simple_body_part_description(body_part)}.")

            tx(text)
          end
        end
      end
    end
  end
end
