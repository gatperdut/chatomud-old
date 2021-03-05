module ChatoMud
  module Mixins
    module Rooms
      module Showable
        def show(character_controller)
          [
            "#{list_title(character_controller, 0)} [#{model.id}]\n",
            "#{list_exits(character_controller)}\n",
            "#{description(character_controller)}\n",
            "#{list_furnitures(character_controller)}",
            "#{list_inventory(character_controller)}",
            "#{list_characters(character_controller)}"
          ].reject(&:empty?).join("\n")
        end

        def show_from_afar(character_controller, distance)
          [
            "#{list_title(character_controller, distance)}",
            "#{list_furnitures(character_controller)}",
            "#{list_inventory(character_controller)}",
            "#{list_characters(character_controller)}"
          ].reject(&:empty?).join("\n")
        end

        def list_title(character_controller, distance)
          return "Somewhere in the dark".blue unless can_be_seen_by_character?(character_controller)

          return "" if distance > 2

          title_formatted
        end

        def list_exits(character_controller)
          return "Exits: " << "?".green unless can_be_seen_by_character?(character_controller)

          exits = []

          connections.each do |direction, connection|
            connecting_door_controller = connection[1]
            exit = direction.to_s.green
            if connecting_door_controller
              exit << " (" << (connecting_door_controller.is_open? ? "open" : "closed") << " #{connecting_door_controller.short_desc})"
            end
            exits << exit
          end

          if exits.present?
            text = "Exits: #{exits.join(', ')}"
          else
            text = "Exits: " << "none".green
          end
          text
        end

        def description(character_controller)
          return "It is pitch black." unless can_be_seen_by_character?(character_controller)

          return model.description if @server.timer.calendar.is_daylight_period? || model.description_nighttime.nil?

          model.description_nighttime
        end

        def list_inventory(character_controller)
          return "" unless can_be_seen_by_character?(character_controller)

          @inventory_controller.list_inventory(:long_desc)
        end

        def can_be_seen_by_character?(character_controller)
          character_controller.has_gift_infravision? ||
          is_always_lit?                             ||
          @server.timer.calendar.is_daylight_period? ||
          is_illuminated?
        end
      end
    end
  end
end
