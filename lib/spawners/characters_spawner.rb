module ChatoMud
  module Spawners
    class CharactersSpawner
      def initialize(server)
        @server = server
        @stopwords_filter = Stopwords::Snowball::Filter.new "en"
      end

      def spawn_npc(npc_template, character_outfit_codes, room_controller, options)
        character = @server.characters_factory.instantiate(npc_template)

        attributes = { npc: true, gladiator: options[:gladiator] }
        attributes.merge!(describe(npc_template))

        character.assign_attributes(attributes)

        character_controller = Controllers::Characters::NpcController.new(@server, character, room_controller)

        @server.characters_outfitter.outfit(character_controller, character_outfit_codes) if character_outfit_codes

        @server.entities_handler.add_bot_controller(character_controller)

        character_controller
      end

      private

      def describe(npc_template)
        name = npc_template.names.sample

        short_descs = [
          npc_template.short_descs.sample,
          npc_template.short_descs.sample
        ]
        short_descs[1] = npc_template.short_descs.sample while short_descs[0] == short_descs[1]

        noun = npc_template.noun

        long_desc_ending = npc_template.long_desc_endings.sample

        short_desc = "a #{short_descs[0]}, #{short_descs[1]} #{noun}"

        kwords = @stopwords_filter.filter(short_desc.split)
        kwords << name

        long_desc = "A #{short_descs[0]}, #{short_descs[1]} #{noun} #{long_desc_ending}."

        {
          name: name,
          short_desc: short_desc,
          long_desc: long_desc,
          kwords: kwords
        }
      end
    end
  end
end
