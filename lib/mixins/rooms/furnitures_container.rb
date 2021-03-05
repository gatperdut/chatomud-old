module ChatoMud
  module Mixins
    module Rooms
      module FurnituresContainer
        def add_furniture_controller(furniture_controller)
          @furniture_controllers << furniture_controller
        end

        def remove_furniture_controller(furniture_controller)
          @furniture_controllers.delete(furniture_controller)
        end

        def accept_character(furniture_controller, remove_from_containing_room)
          furniture_controller.appear_in(self, model, remove_from_containing_room)
        end

        def find_furniture_controller(kword)
          word = kword[:word]
          index = kword[:index]
          if index
            index = index.to_i
          else
            index = 1
          end

          current_index = 0
          @furniture_controllers.each do |furniture_controller|
            if furniture_controller.matches_word(word)
              current_index += 1
              return furniture_controller if current_index == index
            end
          end
          nil
        end

        def accommodation_furnitures
          result = []
          @furniture_controllers.each do |furniture_controller|
            result << furniture_controller if furniture_controller.is_accommodation?
          end

          result
        end

        def list_furnitures(character_controller)
          return "" unless can_be_seen_by_character?(character_controller)

          @furniture_controllers.map(&:long_desc).join("\n")
        end

        def list_accommodations(character_controller = nil)
          accommodation_furniture_controllers = accommodation_furnitures

          return "There are no pieces of furniture here." unless accommodation_furniture_controllers.count.positive?

          text = ""

          accommodation_furniture_controllers.each do |furniture_controller|
            next unless furniture_controller.is_accommodation?

            text << furniture_controller.short_desc
            text << " (#{furniture_controller.list_free_seats})\n"
            text << furniture_controller.list_accommodated(character_controller) if furniture_controller.is_accommodation?
          end
          text
        end
      end
    end
  end
end
