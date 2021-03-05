module ChatoMud
  module Mixins
    module InkTypes
      module Dipping
        def take_one(character_controller)
          use_up_charge

          attributes = {
            slot: character_controller.inventory_controller.get_hold_slot(nil)
          }

          @server.items_spawner.spawn_item(model.spawned_item_template, attributes, nil, character_controller.inventory_controller)
        end
      end
    end
  end
end
