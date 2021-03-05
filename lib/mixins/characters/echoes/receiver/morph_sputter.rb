module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_morph_sputter(params)
            emitter   = params[:emitter]
            location  = params[:location]
            character = params[:character]
            furniture = params[:furniture]
            goes_out  = params[:goes_out]

            case location
              when :room
                text = "#{emitter.short_desc}"
              when :character
                text = interpolate_me_other(character, "#{emitter.short_desc}, which you are carrying,", "#{emitter.short_desc}, carried by #{character.short_desc},")
              when :furniture
                text = "#{emitter.short_desc} in #{furniture.short_desc}"
            end

            text << " goes out."                 if     goes_out
            text << " is but a dim flicker now." unless goes_out

            tx(text)
          end

          private

          def recv_morph_sputter_room
          end
        end
      end
    end
  end
end
