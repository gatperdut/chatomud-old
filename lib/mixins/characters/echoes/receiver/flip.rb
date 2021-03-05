module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_flip(params)
            emitter = params[:emitter]
            target  = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You flip to page #{target.book_controller.current_page} of ", "#{emitter.short_desc} flips the page of ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
