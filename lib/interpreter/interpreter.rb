require "interpreter/parser"

require "actions/base_action"
require_all "lib/actions/**/*.rb"

module ChatoMud
  module Grammar
    class Interpreter
      def initialize(server, character_controller)
        @server = server
        @character_controller = character_controller
        @parser = Parser.new
      end

      def exec(command, redirect_to = nil)
        @character_controller.entity_controller.log(command) if @character_controller.entity_controller.present?
        if is_possessed? && !is_quiet_possession?
          handle_command_while_possessed(command)
          return
        end
        json = parse_and_transform(command)

        performer = is_possessing? ? possessed_character : @character_controller

        if json
          instantiate_action(performer, json, redirect_to)
        else
          handle_wrong_command
        end

        json.present?
      end

      private

      def parse_and_transform(command)
        @parser.parse(command)
      rescue Parslet::ParseFailed
        nil
      end

      def instantiate_action(performer, json, redirect_to)
        key = json.keys[0]
        params = json[key]

        action = Actions.const_get(key.to_s.camelize).new(@server, performer, params, redirect_to)
        action.exec
      end

      def handle_wrong_command
        if is_possessing?
          @character_controller.tx("Huh? Won't pass it on to your prey.", true)
        else
          @character_controller.tx("Huh?")
        end
      end

      def handle_command_while_possessed(command)
        @character_controller.tx("You'll be unable to perform any action until the presence leaves your mind.", true)
        @character_controller.entity_controller.possession_controller.possessing_controller.tx("You feel your prey struggling with '#{command}'.", true)
      end

      def possessed_character
        @character_controller.entity_controller.possession_controller.possessed_controller.character_controller
      end

      def is_possessing?
        @character_controller.entity_controller.possession_controller.is_possessing?
      end

      def is_possessed?
        @character_controller.entity_controller.possession_controller.is_possessed?
      end

      def is_quiet_possession?
        @character_controller.entity_controller.possession_controller.quietly
      end
    end
  end
end
