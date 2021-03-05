module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_tear_book(params)
            emitter = params[:emitter]
            target  = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You carefully tear page #{target.book_controller.current_page} off ", "#{emitter.short_desc} carefully tears the page off ")

            text << "#{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
