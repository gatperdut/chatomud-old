module ChatoMud
  module Mixins
    module Rooms
      module CharactersContainer
        def add_character_controller(character_controller)
          @character_controllers << character_controller
        end

        def remove_character_controller(character_controller)
          @character_controllers.delete(character_controller)
        end

        def accept_character(character_controller, remove_from_containing_room)
          character_controller.appear_in(self, model, remove_from_containing_room)
        end

        def find_character_controller(kword)
          word = kword[:word]
          index = kword[:index]
          if index
            index = index.to_i
          else
            index = 1
          end

          current_index = 0
          character_controllers.each do |character_controller|
            next unless character_controller.visibility_controller.is_visible?

            if character_controller.matches_word(word)
              current_index += 1
              return character_controller if current_index == index
            end
          end
          nil
        end

        def character_controllers(include_invisible = false)
          @character_controllers.select do |character_controller|
            include_invisible || character_controller.visibility_controller.is_visible?
          end
        end

        def pc_controllers
          character_controllers.select(&:is_pc?)
        end

        def npc_controllers
          character_controllers.select(&:is_npc?)
        end

        def character_count
          character_controllers.size
        end

        def list_characters(character_controller)
          return "" unless can_be_seen_by_character?(character_controller)

          (character_controllers - [character_controller]).map do |cc|
            text = "#{cc.long_desc}"
            text << " (grouped)".red if cc.group_controller.is_member?(character_controller)
            text
          end.join("\n")
        end
      end
    end
  end
end
