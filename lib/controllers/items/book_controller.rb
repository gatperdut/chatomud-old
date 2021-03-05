require "mixins/items/book"
require "mixins/scripts/utils"
require "controllers/items/posts_holder_controller"

module ChatoMud
  module Controllers
    module Items
      class BookController < PostsHolderController
        include Mixins::Items::Book
        include Mixins::Scripts::Utils

        def initialize(server, item_controller, book)
          super(server, item_controller, book.posts)
          @book = book
        end

        def find_post_controller_for_page(page = nil)
          page = current_page if page.nil?

          return nil if page.nil?

          @post_controllers.find do |post_controller|
            post_controller.page == page
          end
        end

        def find_post_controllers_after_current_page
          @post_controllers.select do |post_controller|
            post_controller.page > current_page
          end
        end

        def read(character_controller)
          post_controller = find_post_controller_for_page

          if post_controller.nil?
            return "It has no pages, just the covers." if current_page.nil?
            return "It has not been titled yet."       if current_page.zero?

            return "Page #{current_page} is blank."
          end

          data = post_controller.read_data(character_controller)

          if current_page.zero?
            "#{data[:script_description]} #{data[:script]} sigils in #{data[:ink_type]} give this book the following title in #{data[:language]}: \n\n\"#{data[:text]}\""
          else
            "On page #{current_page}, #{data[:script_description]} #{data[:script]} sigils in #{data[:ink_type]} bear the following in #{data[:language]}: \n\n#{data[:text]}"
          end
        end

        def tear_page(character_controller)
          posterior_post_controllers = find_post_controllers_after_current_page

          post_controller = find_post_controller_for_page

          remove_post_controller(post_controller)

          post_controller&.bye

          posterior_post_controllers.each(&:reduce_page)

          @book.reload

          @book.page_count = @book.page_count - 1

          @book.current_page = @book.current_page - 1 if current_page > page_count
          @book.current_page = nil                    if has_no_pages?

          @book.save!

          @server.items_spawner.spawn_writing(character_controller, post_controller)
        end

        def receive_title(character_controller, writing_implement_controller, title)
          language = character_controller.choice_controller.language
          script   = character_controller.choice_controller.script

          text_info_attributes = {
            character_id:       character_controller.id,
            ink_type:           writing_implement_controller.ink_type,
            language:           language,
            script:             script,
            language_skill_mod: character_controller.stats_controller.skill_modifier(language),
            script_skill_mod:   character_controller.stats_controller.skill_modifier(script)
          }

          post_attributes = {
            content:   title,
            page:      0,
            text_info: TextInfo.new(text_info_attributes)
          }

          post = Post.new(post_attributes)

          @book.posts << post

          @book.save!

          add_post_controller(post)

          writing_implement_controller.discharge
        end

        def model
          @book
        end

        def write(character_controller, writing_implement_controller)
          data = {
            writing_implement_controller: writing_implement_controller,
            text:                         nil
          }

          character_controller.editing_controller.start_editing(method(:write_callback), data)
        end

        private

        def write_callback(data)
          character_controller = data[:character_controller]

          language = character_controller.choice_controller.language

          script   = character_controller.choice_controller.script

          text_info_attributes = {
            character_id:       character_controller.id,
            ink_type:           data[:writing_implement_controller].ink_type,
            language:           language,
            language_skill_mod: character_controller.stats_controller.skill_modifier(language),
            script:             script,
            script_skill_mod:   character_controller.stats_controller.skill_modifier(script)
          }

          post_attributes = {
            page:      current_page,
            title:     nil,
            content:   data[:text],
            text_info: TextInfo.new(text_info_attributes)
          }

          post = Post.new(post_attributes)

          @book.posts << post

          @book.save!

          add_post_controller(post)

          data[:writing_implement_controller].discharge
        end
      end
    end
  end
end
