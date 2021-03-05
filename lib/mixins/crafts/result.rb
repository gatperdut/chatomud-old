module ChatoMud
  module Mixins
    module Crafts
      module Result
        # @ingredients =
        # {
        #   craft_ingredient: craft_ingredient,
        #   item_templates:   item_templates,
        #   results:          results
        # }
        def handle_craft_item_result(craft_item_result)
          item_template = ItemTemplate.find_by_code(craft_item_result.item_template_code)

          attributes = {}
          if item_template.stack.present?
            how_many = craft_item_result.how_many || 1
            attributes.merge!(
              {
                stack_attributes: {
                  current: how_many,
                  max:     how_many
                }
              }
            )
          end

          new_item_controller = @server.items_spawner.spawn_item(item_template, attributes, nil, @character_controller.room_controller.inventory_controller)

          new_item_controller
        end
      end
    end
  end
end
