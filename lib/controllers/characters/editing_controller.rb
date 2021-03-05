module ChatoMud
  module Controllers
    module Characters
      class EditingController
        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller

          @data     = nil
          @buffer   = ""
          @callback = nil
        end

        def start_editing(callback, data)
          @callback = callback

          @data = data

          @data[:character_controller] = @character_controller

          @character_controller.tx("Enter your writing here. Do use proper linebreaks and try to respect the\nlimitations of the physical medium, if any. Enter the '@' character by itself\nin a new line to terminate.\n1-------10--------20--------30--------40--------50--------60--------70--------80")

          @character_controller.entity_controller.state = :editing
        end

        def process_line(line)
          if line == "@"
            finish_editing
            return
          end

          @character_controller.tx(line) if @character_controller.choice_controller.editor_echoes

          @buffer << "#{line}\n"
        end

        def clean_up
          @data     = nil
          @buffer   = ""
          @callback = nil
        end

        def finish_editing
          @character_controller.entity_controller.state = :in_game

          @data[:text] = @buffer[0..].strip

          if @data[:text].blank?
            @character_controller.tx("Done. No writing was performed.".cyan)
          else
            @callback.call(@data)
            @character_controller.tx("Done.".cyan)
          end

          clean_up
        end

        def interrupt_editing
          return unless @character_controller.entity_controller.is_editing?

          @character_controller.entity_controller.state = :in_game

          clean_up

          @character_controller.tx("You stop editing. Something requires your immediate attention!".red)
        end
      end
    end
  end
end
