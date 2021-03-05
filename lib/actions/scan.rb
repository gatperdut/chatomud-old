require "facets/string/margin"

module ChatoMud
  module Actions
    class Scan < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        text = ""

        room_controller.connections.each do |direction, connection|
          connecting_room_controller = connection[0]
          connecting_door_controller = connection[1]

          text << "#{direction}ward, #{connecting_room_controller.title_formatted}, you see...\n"

          if !connecting_door_controller || connecting_door_controller.is_open?
            room_content = connecting_room_controller.show_from_afar(@character_controller, 1)

            room_content = "Nothing of interest." if room_content.blank?

            text << room_content.margin(2)
          else
            text << "Your view is blocked by the #{connecting_door_controller.short_desc}.".margin(2)
          end

          text << "\n"
        end

        if text.blank?
          text = "There is nowhere to scan."
        end

        tx(text)
      end
    end
  end
end
