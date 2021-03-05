require "mixins/players/login"
require "mixins/players/main_menu"
require "controllers/entities/entity_controller"
require "controllers/characters/pc_controller"

require "actions/look_around"

module ChatoMud
  module Controllers
    module Entities
      class PlayerController < EntityController
        include Mixins::Players::Login
        include Mixins::Players::MainMenu

        attr_accessor :state

        def initialize(server, thread, socket)
          super(server, thread)

          @logger = nil

          @socket = socket
          @state = :providing_username
          @waiting_for_reconnection = false
          @authentication_attempts = 0
          @player = nil
          @character_controller = nil
        end

        def bye(must_close_socket)
          close_socket if must_close_socket
          super()
        end

        def handle_character_death
          @state = :main_menu
          tx("It seems you character has passed away. Our condolences ...\n\nThank you for playing Arda Marred. We hope to see you again soon.\n\n")
          super
        end

        def process
          tx("Arda Marred\n".green) # ASCII art here
          loop do
            rx_result = :bad
            begin
              rx_result, input = @socket.rx
            rescue StandardError
              # Empty
            end

            case rx_result
              when :bad
                handle_disconnection
              when :ok
                case @state
                  when :providing_username
                    check_exit_request_out_of_game(input)
                    handle_username(input)
                  when :providing_password
                    check_exit_request_out_of_game(input)
                    handle_password(input, @socket)
                  when :main_menu
                    check_exit_request_out_of_game(input)
                    case handle_main_menu(input)
                      when :enter_game
                        @state = :in_game
                        handle_enter_game
                      when :toggle_ansi_coloring
                        handle_toggle_ansi_coloring
                      when :no_character
                        handle_no_character
                      else
                        handle_invalid_input
                    end
                  when :in_game
                    handle_command(input)
                  when :editing
                    @character_controller.editing_controller.process_line(input)
                end
            end
          end
        end

        def check_exit_request_out_of_game(input)
          bye(true) if input == "exit"
        end

        def close_socket
          Rails.logger.info("Closing socket.")
          @socket.close
        end

        def tx(message, vessel = false)
          log(message.uncolorize)

          message = message.uncolorize unless player_available? && @player.setting.ansi_coloring

          # here vessel means 'intended only for the vessel'
          if @possession_controller.is_possessed?
            @socket.tx("#{message}\n#{show_prompt}")
            @possession_controller.possessing_controller.tx(message, true) unless vessel
            return
          end

          # here vessel means 'vessel received this, and you too'
          if @possession_controller.is_possessing?
            @socket.tx("#{message}\n#{show_prompt}") if vessel
            return
          end

          @socket.tx("#{message}\n#{show_prompt}")
        end

        def handle_reconnection(socket)
          if @waiting_for_reconnection
            @waiting_for_reconnection = false
            @socket = socket
            @thread.wakeup
            :reconnection
          else
            :multilogin
          end
        end

        def human_address
          @socket.human_address
        end

        def player_available?
          !!@player
        end

        def id
          @player.id
        end

        def is_logging_in?
          [:providing_username, :providing_password].include?(@state)
        end

        def is_logged_in?
          [:in_game, :editing, :main_menu].include?(@state)
        end

        def is_in_main_menu?
          [:main_menu].include?(@state)
        end

        def is_in_game?
          [:in_game, :editing].include?(@state)
        end

        def is_editing?
          [:editing].include?(@state)
        end

        def is_waiting_for_reconnection?
          @waiting_for_reconnection
        end

        def is_player?
          true
        end

        def is_bot?
          false
        end

        def handle_leave_game
          @character_controller.bye
          @character_controller = nil
          @state = :main_menu
          tx("You leave the area ...\n")
        end

        def show_prompt
          if is_logging_in?
            show_login_prompt
          elsif is_in_main_menu?
            show_main_menu_prompt
          elsif is_editing?
            # Do nothing.
          elsif @possession_controller.is_possessing?
            text = @possession_controller.possessed_controller.character_controller.quick_status
            text << "<".red
            text << @possession_controller.possessed_controller.character_controller.short_desc
            text << ">".red
            text
          else
            @character_controller.quick_status
          end
        end

        def log(content)
          @logger&.info(content)
        end

        private

        def handle_enter_game
          @character_controller = Controllers::Characters::PcController.new(@server, self, @player.current_character, @server.rooms_handler.find(@player.current_character.room.id))
          @character_controller.emit_enter_area
          Actions::LookAround.new(@server, @character_controller, nil).exec
        end

        def handle_disconnection
          @possession_controller.handle_disconnection_when_possessing
          @possession_controller.handle_disconnection_when_possessed

          close_socket
          if is_in_game?
            @character_controller.emit_disconnection
            wait_for_reconnection
          else
            bye(false)
          end
        end

        def wait_for_reconnection
          @waiting_for_reconnection = true
          Rails.logger.warn("#{@player.username} disconnected. Thread sleeping ...")
          sleep(10.seconds)
          if @waiting_for_reconnection
            Rails.logger.warn("#{@player.username}'s link dead too long. Closing connection.")
            bye(true)
          end
          tx("\nWelcome back, #{@player.username}.\n")
          @character_controller.emit_reconnection
          Rails.logger.warn("#{@player.username} has reconnected.")
          Actions::LookAround.new(@server, @character_controller, nil).exec
        end

        def create_logger
          @logger = ::Logger.new("log/#{Rails.env}/players/#{@player.username}.log")
          @logger.level = 1
        end
      end
    end
  end
end
