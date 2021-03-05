module ChatoMud
  module Actions
    class SimpleSpawnNpc < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to spawn other NPCs.")

        npc_template_code = @params[:npc_template_code].to_s

        npc_template = CharacterTemplate.find_by_code(npc_template_code)

        return unless check_target_present(npc_template, "Cannot find character template with code '#{npc_template_code}'.")

        character_controller = @server.characters_spawner.spawn_npc(npc_template, nil, @character_controller.room_controller, { gladiator: false })
        tx("Spawned #{character_controller.short_desc}.")
      end
    end
  end
end
