module ChatoMud
  module Actions
    class SimpleSpawnItem < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to spawn items.")

        item_template_code = @params[:item_template_code].to_s

        item_template = ItemTemplate.find_by_code(item_template_code)

        return unless check_target_present(item_template, "Cannot find item template with code '#{item_template_code}'.")

        item_controller = @server.items_spawner.spawn_item(item_template, {}, nil, @character_controller.room_controller.inventory_controller)
        tx("Spawned #{item_controller.short_desc}.")
      end
    end
  end
end
