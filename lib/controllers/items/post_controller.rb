require "mixins/scripts/utils"
require "mixins/ink_types/utils"
require "action_view/helpers"

module ChatoMud
  module Controllers
    module Items
      class PostController
        include Mixins::Scripts::Utils
        include Mixins::InkTypes::Utils
        include ActionView::Helpers::DateHelper

        def initialize(server, parent_controller, post)
          @server = server
          @parent_controller = parent_controller
          @post = post
        end

        def as_headline
          "#{@server.timer.calendar.compact_time_string(@post.created_at)} - #{@post.title}"
        end

        def wipe
          post_attributes = {
            content:   nil,
            text_info: nil
          }

          @post.update_attributes(post_attributes)
        end

        def header
          if @post.text_info.character
            text = "#{@post.text_info.character.short_desc.magenta} was seen spreading the following"
          else
            text = "The following was made known"
          end

          text << " #{time_ago_in_words(Time.now - (Time.now - @post.created_at) * 4)} ago:"

          text
        end

        def read_data(character_controller)
          data = {}

          if character_controller.is?(@post.text_info.character)
            data[:text]     = content
            data[:language] = text_info.language
            data[:script]   = text_info.script
          else
            data[:text]     = character_controller.comms_controller.understand_written(content, text_info)
            data[:language] = character_controller.comms_controller.guess_written_language(text_info.language)
            data[:script]   = character_controller.comms_controller.guess_script(text_info.script)
          end

          data[:script_description] = script_description(text_info, character_controller)
          data[:ink_type]           = ink_type_name

          data
        end

        def ink_type_name
          ink_type_name_for(text_info.ink_type)
        end

        def reduce_page
          @post.page = @post.page - 1
          @post.save!
        end

        def page
          @post.page
        end

        def content
          @post.content
        end

        def has_content?
          @post.content.present?
        end

        def character
          @post.character
        end

        def text_info
          @post.text_info
        end

        def update_attributes(post_attributes)
          @post.update_attributes(post_attributes)
        end

        def bye
          @post.destroy
        end

        def model
          @post
        end
      end
    end
  end
end
