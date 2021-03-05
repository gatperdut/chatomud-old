module ChatoMud
  module Spawners
    module Outfitters
      class CharactersOutfitter
        def initialize(server)
          @server = server
        end

        def outfit(character_controller, item_template_codes)
          item_template_codes.each_key do |wloc_key|
            entry = item_template_codes[wloc_key][0]
            item_controller = nil
            case entry.class.name.to_sym
              when :Hash
                container_code = entry.keys[0]
                item_controller = @server.items_spawner.spawn_item(ItemTemplate.find_by_code(container_code), {}, entry[container_code], character_controller.inventory_controller, {})
              when :Symbol
                item_template = ItemTemplate.find_by_code(entry)
                attributes = {
                  slot: wloc_key
                }
                item_controller = @server.items_spawner.spawn_item(item_template, attributes, nil, character_controller.inventory_controller)
            end
            item_controller.set_slot(wloc_key, true)
          end
        end
      end
    end
  end
end
