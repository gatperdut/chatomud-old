module ChatoMud
  module Arena
    class ArenaMaster
      def initialize(server)
        @server = server
        @room_controllers = @server.rooms_handler.arena_rooms
        @npc_controllers = Character.gladiators

        check_replenished
      end

      def replenish
        npc_template = CharacterTemplate.find_by_code("gob_01")

        @server.characters_spawner.spawn_npc(npc_template, CharacterOutfitter.find_by_code("gothakra_01").item_template_codes, @room_controllers[1], { gladiator: true })
      end

      def check_replenished
        (3 - @npc_controllers.count).times do
          replenish
        end
      end
    end
  end
end
