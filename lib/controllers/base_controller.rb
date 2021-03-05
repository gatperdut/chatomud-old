module ChatoMud
  module Controllers
    class BaseController
      def initialize(server)
        @server = server
      end

      def is_item_controller?
        self.class <= Items::ItemController
      end

      def is_furniture_controller?
        self.class <= Furnitures::FurnitureController
      end

      def is_character_controller?
        self.class <= Characters::CharacterController
      end

      def is_room_controller?
        self.class <= Rooms::RoomController
      end
    end
  end
end
