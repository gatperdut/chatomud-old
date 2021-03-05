module ChatoMud
  module Spawners
    module Outfitters
      class ItemsOutfitter
        def initialize(server)
          @server = server
        end

        def outfit(item_controller, item_template_codes)
          item_template_codes.each do |itc|
            case itc
              when Hash
                itc.each_key do |key|
                  new_item_controller = @server.items_spawner.spawn_item(ItemTemplate.find_by_code(key), {}, nil, item_controller.inventory_controller, {})
                  outfit(new_item_controller, itc[key])
                end
              when Array
                itc.each do |code|
                  outfit(item_controller, [code])
                end
              when Symbol
                @server.items_spawner.spawn_item(ItemTemplate.find_by_code(itc), {}, nil, item_controller.inventory_controller, {})
            end
          end
        end
      end
    end
  end
end
