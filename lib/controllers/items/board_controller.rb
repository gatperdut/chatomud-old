require "controllers/items/posts_holder_controller"

module ChatoMud
  module Controllers
    module Items
      class BoardController < PostsHolderController
        PAGE_SIZE = 10

        def initialize(server, item_controller, board)
          super(server, item_controller, board.posts)
          @board = board
        end

        def page_count
          (post_count / PAGE_SIZE.to_f).ceil
        end

        def indices_for_page(page)
          first = (page - 1) * PAGE_SIZE
          last  = [first + PAGE_SIZE - 1, post_count - 1].min

          (first..last)
        end

        def list(page)
          post_controllers = @post_controllers[indices_for_page(page)]

          count = post_count

          result = "#{@item_controller.short_desc}: (page #{page} of #{page_count})\n\n"
          post_controllers.each_with_index do |post_controller, index|
            result << "#{count - index - (page - 1) * PAGE_SIZE} - #{post_controller.as_headline}\n"
          end

          result
        end

        def show(index)
          post_controller = @post_controllers[post_count - index]

          text = "#{post_controller.header}\n\n"
          text << post_controller.content

          text
        end

        def post(character_controller, title)
          data = {
            title: title,
            text:  nil
          }

          character_controller.editing_controller.start_editing(method(:post_callback), data)
        end

        private

        def post_callback(data)
          text_info_attributes = {
            character_id: data[:character_controller].id
          }

          post_attributes = {
            page:      nil,
            title:     data[:title],
            content:   data[:text],
            text_info: TextInfo.new(text_info_attributes)
          }

          post = Post.new(post_attributes)

          @board.posts << post

          @board.save!

          add_post_controller(post)
        end
      end
    end
  end
end
