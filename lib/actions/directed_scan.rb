module ChatoMud
  module Actions
    class DirectedScan < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        direction = @params[:direction].keys[0]

        text = "You focus #{direction}ward ..."

        line_of_sight = room_controller.line_of_sight(direction, 3)

        line_of_sight.each_with_index do |connection, index|
          connecting_room_controller = connection[0]

          text << "\n#{connecting_room_controller.title.light_black}\n"

          room_content = connecting_room_controller.show_from_afar(@character_controller, index + 1)
          room_content = "Nothing of interest." if room_content.blank?

          text << "#{room_content.margin(2)}"

          text << "\n"
        end

        text << " your view is blocked.".margin(2) if line_of_sight.empty?

        tx(text)
      end
    end
  end
end
