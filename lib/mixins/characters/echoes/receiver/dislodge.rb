module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_dislodge(params)
            emitter   = params[:emitter]
            body_part = params[:body_part]
            missile   = params[:missile]
            target    = params[:target]

            text = interpolate_me_others(emitter, target, "You dislodge ", "#{emitter.short_desc} dislodges ", "#{emitter.short_desc} dislodges ")

            text << "#{missile.short_desc} from "

            text << interpolate_me_others(emitter, target, "#{body_part_description(body_part)}", "your #{simple_body_part_description(body_part)}", "#{body_part_description(body_part)}")

            text << interpolate_me_others(emitter, target, " of #{target.short_desc}.", ".", " of #{target.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
