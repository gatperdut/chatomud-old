module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_switch(params)
            emitter = params[:emitter]
            left = params[:left]
            right = params[:right]

            return unless can_see_action?(emitter)

            single = !left || !right

            pronoun = interpolate_possessive(emitter)

            text = interpolate_me_other(emitter, "You switch ", "#{emitter.short_desc} switches ")

            if single
              text << "#{right.short_desc} to #{pronoun} left hand." if right
              text << "#{left.short_desc} to #{pronoun} right hand." if left
            else
              text << "#{right.short_desc} to #{pronoun} left hand, and #{left.short_desc} to #{pronoun} right hand."
            end

            tx(text)
          end
        end
      end
    end
  end
end
