require "controllers/items/item_controller"

module ChatoMud
  module Spawners
    class ItemsSpawner
      def initialize(server)
        @server = server
      end

      def spawn_corpse(character_controller)
        attributes = {
          short_desc: "the corpse of #{character_controller.short_desc.uncolorize}",
          long_desc:  "Here rests the corpse of #{character_controller.short_desc.uncolorize}.",
          full_desc:  "This is the corpse of #{character_controller.short_desc.uncolorize}.",
          kwords:     ["corpse"],
          inventory:  Inventory.new
        }
        spawn_item(ItemTemplate.find_by_code("corpse_01"), attributes, nil, character_controller.room_controller.inventory_controller)
      end

      def spawn_writing(character_controller, post_controller)
        attributes = {
          slot: character_controller.inventory_controller.get_hold_slot(nil),
          writing: Writing.new(
            post: Post.new(
              content: post_controller.nil? ? nil : post_controller.content,
              page: nil
            )
          )
        }
        unless post_controller.nil?
          attributes[:writing].post.text_info = TextInfo.new(
            language:           post_controller.text_info.language,
            script:             post_controller.text_info.script,
            language_skill_mod: post_controller.text_info.language_skill_mod,
            script_skill_mod:   post_controller.text_info.script_skill_mod,
            character_id:       post_controller.text_info.character.id
          )
        end
        spawn_item(ItemTemplate.find_by_code("parchment_01"), attributes, nil, character_controller.inventory_controller)
      end

      def spawn_item(item_template, attributes, item_outfit_codes, inventory_controller)
        item = @server.items_factory.instantiate(item_template)

        item.assign_attributes(attributes)

        item_controller = Controllers::Items::ItemController.new(@server, item, inventory_controller)

        @server.items_outfitter.outfit(item_controller, item_outfit_codes) if item_outfit_codes

        item_controller
      end
    end
  end
end
