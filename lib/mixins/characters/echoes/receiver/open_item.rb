module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_open_item(params)
            emitter   = params[:emitter]
            target    = params[:target]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You open ", "#{emitter.short_desc} opens ")

            text << "#{target.short_desc}"

            text << " to the first page" if target.is_book? && target.book_controller.has_pages?

            text << "."

            tx(text)
          end
        end
      end
    end
  end
end
