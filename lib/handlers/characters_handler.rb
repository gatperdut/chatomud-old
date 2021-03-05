# TODO: add logging (inherited from server?)

module ChatoMud
  module Handlers
    class CharactersHandler
      attr_reader :character_controllers

      def initialize(server)
        @server = server
        @character_controllers = []
      end

      def report
        text = "*** CHARACTERS HANDLER\n"
        text << "#{@character_controllers.size} characters in-game.\n"
        text << "#{pc_controllers.size} of them human-controlled.\n"
        text << "#{npc_controllers.size} of them bot-controlled.\n"
        text
      end

      def add_character_controller(character_controller)
        Rails.logger.info("Adding character to main list.")
        @character_controllers << character_controller
      end

      def remove_character_controller(character_controller)
        Rails.logger.info("Removing character from main list.")
        @character_controllers.delete(character_controller)
      end

      def bye
        @character_controllers.each(&:bye)
        @character_controllers.clear
      end

      def find(id)
        @character_controllers.select { |character_controller| character_controller.id == id }[0]
      end

      def find_by_name(name)
        @character_controllers.select do |character_controller|
          character_controller.name.downcase.starts_with?(name)
        end[0]
      end

      def awho
        text = "\n"
        pc_controllers.each do |character_controller|
          text << "#{character_controller.name.green} - #{character_controller.room_controller.title_formatted}"
          if character_controller.combat_controller.is_in_combat?
            text << " [" + "COMBAT".red + "]"
          end
          unless character_controller.health_controller.is_conscious?
            text << " [" + "UNCONSCIOUS".red + "]"
          end
          text << "\n"
        end
        text << "\n"
      end

      def pc_controllers
        @character_controllers.select(&:is_pc?)
      end

      def npc_controllers
        @character_controllers.select(&:is_npc?)
      end
    end
  end
end
