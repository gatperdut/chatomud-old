module ChatoMud
  module Mixins
    module Players
      module MainMenu
        def show_main_menu_prompt
          case @state
            when :main_menu
              text = "\nArda Marred\n".green
              if @player.current_character
                text << " 1) Enter game with #{@player.current_character.name}"
              else
                text << " x) <no character available>"
              end

              ansi_line = "\n 2) Toggle ANSI coloring "
              if @player.setting.ansi_coloring
                ansi_line << ("(#{'on'.green})")
              else
                ansi_line << ("(off)")
              end
              text << ansi_line

              text << "\n'exit' to quit."

              text
            else
              Rails.logger.error("Wrong state when showing main menu prompt.")
          end
        end

        def handle_main_menu(input)
          if input == "1"
            return :no_character unless @player.current_character

            return :enter_game
          end

          return :toggle_ansi_coloring if input == "2"

          :not_valid
        end

        def handle_no_character
          tx("You'll need to first create a character at ardamarred.com.\n")
        end

        def handle_invalid_input
          tx("That's not a valid option, friend.\n")
        end

        def handle_toggle_ansi_coloring
          @player.setting.toggle(:ansi_coloring)
          @player.setting.save!
          tx("ANSI coloring is now #{'on'.green}.\n") if @player.setting.ansi_coloring
          tx("ANSI coloring is now off.\n") unless @player.setting.ansi_coloring
        end
      end
    end
  end
end
