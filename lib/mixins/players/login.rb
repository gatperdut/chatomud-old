module ChatoMud
  module Mixins
    module Players
      module Login
        def show_login_prompt
          case @state
            when :providing_username
              "Your username? 'exit' to quit."
            when :providing_password
              "Your password? 'exit' to quit."
            else
              Rails.logger.error("Wrong state when showing login prompt.")
          end
        end

        def handle_username(username)
          @player = Player.find_by_username(username)
          if @player
            @state = :providing_password
            tx("Alright.\n")
          else
            tx("That username does not exist.\n")
          end
        end

        def handle_password(password, socket)
          if @player.try(:authenticate, password)
            handle_correct_authentication(socket)
          else
            handle_failed_authentication
          end
        end

        private

        def handle_correct_authentication(socket)
          case @server.entities_handler.check_duplicate(self, socket)
            when :not_duplicate
              @state = :main_menu
              create_logger
              tx("\nWelcome, #{@player.username}.\n")
            when :multilogin
              tx("That account is already logged in. This has been reported ...")
              Rails.logger.warn("Double authentication attempt for #{@player.username} from #{@socket.human_address}")
              bye(true)
            when :reconnection
              bye(false)
          end
        end

        def handle_failed_authentication
          @authentication_attempts += 1
          if @authentication_attempts < 3
            tx("Wrong password.\n")
          else
            tx("Wrong password for the third time. This has been reported ...")
            Rails.logger.warn("Three failed password attempts on #{@player.username} from #{@socket.human_address}")
            bye(true)
          end
        end
      end
    end
  end
end
