module ChatoMud
  module Controllers
    module Items
      class WritingController
        attr_reader :post_controller

        def initialize(server, item_controller, writing)
          @server = server
          @item_controller = item_controller
          @writing = writing

          @post_controller = PostController.new(@server, self, @writing.post)
        end

        def is_wipeable?
          @writing.wipeable
        end

        def is_not_wipeable?
          !is_wipeable?
        end

        def wipe
          @post_controller.wipe
        end

        def read(character_controller)
          return "It is blank." unless @post_controller.has_content?

          data = @post_controller.read_data(character_controller)

          "#{data[:script_description]} #{data[:script]} sigils in #{data[:ink_type]} bear the following in #{data[:language]}: \n\n#{data[:text]}"
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
            content:   data[:text],
            text_info: TextInfo.new(text_info_attributes)
          }

          @post_controller.update_attributes(post_attributes)

          data[:writing_implement_controller].discharge
        end
      end
    end
  end
end
