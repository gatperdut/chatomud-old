require "controllers/items/post_controller"

module ChatoMud
  module Controllers
    module Items
      class PostsHolderController
        attr_reader :post_controllers

        def initialize(server, item_controller, posts)
          @server = server
          @item_controller = item_controller

          @post_controllers = []
          posts.each do |post|
            add_post_controller(post)
          end
        end

        def add_post_controller(post)
          @post_controllers.unshift(PostController.new(@server, self, post))
        end

        def post_count
          @post_controllers.count
        end

        def empty?
          post_count.zero?
        end

        def remove_post_controller(post_controller)
          @post_controllers.delete(post_controller) unless post_controller.nil?
        end
      end
    end
  end
end
