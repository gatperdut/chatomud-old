require "controllers/rooms/room_controller"

module ChatoMud
  module Handlers
    class RoomsHandler
      def initialize(server)
        @server = server
        @room_controllers = []
      end

      def bye
        @room_controllers.each(&:bye)
        @room_controllers.clear
      end

      def add_room_controller(room_controller)
        @room_controllers << room_controller
      end

      def remove_room_controller(room_controller)
        @room_controllers.delete(room_controller)
      end

      def report
        text = "*** ROOMS HANDLER\n"
        text << "#{@room_controllers.size} rooms loaded.\n"
        @room_controllers.each do |room_controller|
          text << "#{room_controller.title}: #{room_controller.inventory_controller.item_count} items, #{room_controller.character_count} characters.\n"
        end
        text
      end

      def find(id)
        @room_controllers.select { |room_controller| room_controller.id == id }[0]
      end

      def load_rooms
        Room.all.each do |room|
          Controllers::Rooms::RoomController.new(@server, room)
        end
      end

      def arena_rooms
        @room_controllers.select(&:is_arena?)
      end

      def broadcast_action_echo(echo, params)
        @room_controllers.each do |room_controller|
          room_controller.emit_action_echo(echo, params)
        end
      end

      def broadcast_echo(text)
        @room_controllers.each do |room_controller|
          room_controller.emit_echo(nil, text)
        end
      end
    end
  end
end
