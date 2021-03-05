module ChatoMud
  module Mixins
    module Furnitures
      module Accommodator
        def accommodate(position_controller)
          @position_controllers << position_controller
        end

        def unaccommodate(position_controller)
          @position_controllers.delete(position_controller)
        end

        def max_seats
          @furniture.max_seats
        end

        def taken_seats
          @position_controllers.count
        end

        def free_seats
          max_seats - taken_seats
        end

        def is_accommodation?
          max_seats.positive?
        end

        def is_full?
          taken_seats == max_seats
        end

        def is_empty?
          taken_seats.zero?
        end

        def list_free_seats
          is_full? ? "no free seats" : "#{free_seats} seats free"
        end

        def list_accommodated(character_controller = nil)
          text = ""
          @position_controllers.each do |position_controller|
            description = position_controller.character_controller.short_desc
            description = description.uncolorize.light_magenta if position_controller.character_controller == character_controller
            text << "  #{description}\n"
          end
          text
        end
      end
    end
  end
end
