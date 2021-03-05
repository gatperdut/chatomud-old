module ChatoMud
  module Mixins
    module Actions
      module Helpers
        module Items
          def handle_spawned_stack(item_controller, amount, inventory_controller)
            attributes = item_controller.split_stack_attributes(amount)

            attributes[:slot] = inventory_controller.get_hold_slot(item_controller) if inventory_controller.owner_controller.is_character_controller?

            new_item_controller = @server.items_spawner.spawn_item(item_controller.template, attributes, nil, inventory_controller)

            item_controller.stack_controller.consume(amount)

            new_item_controller
          end
        end
      end
    end
  end
end
