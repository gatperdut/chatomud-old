require "controllers/base_controller"

require "controllers/furnitures/furniture_controller"

require "mixins/rooms/showable"
require "mixins/rooms/illuminable"
require "mixins/rooms/connected"
require "mixins/rooms/characters_container"
require "mixins/rooms/furnitures_container"
require "mixins/rooms/echoes/emitter/emitter"

module ChatoMud
  module Controllers
    module Rooms
      class RoomController < BaseController
        attr_reader :inventory_controller

        include Mixins::Rooms::Showable
        include Mixins::Rooms::Illuminable
        include Mixins::Rooms::Connected
        include Mixins::Rooms::CharactersContainer
        include Mixins::Rooms::FurnituresContainer
        include Mixins::Rooms::Echoes::Emitter

        def initialize(server, room)
          super(server)
          @room = room
          @character_controllers = []
          @furniture_controllers = []
          @inventory_controller = Inventories::BoxInventoryController.new(@server, self, @room.inventory)
          @room.furnitures.each do |furniture|
            Furnitures::FurnitureController.new(@server, furniture, self)
          end
          @server.rooms_handler.add_room_controller(self)
        end

        def reload_model
          @room = Room.find(@room.id)
        end

        def area_controller
          @server.areas_handler.find(@room.area_id)
        end

        def is_arena?
          @room.arena
        end

        def is_always_lit?
          @room.always_lit
        end

        def is_enclosed?
          @room.enclosed
        end

        def roughness_multiplier
          @room.roughness_multiplier
        end

        def bye
          @server.rooms_handler.remove_room_controller(self)
        end

        def id
          @room.id
        end

        def title
          @room.title
        end

        def title_formatted
          title.cyan
        end

        def model
          @room
        end
      end
    end
  end
end
