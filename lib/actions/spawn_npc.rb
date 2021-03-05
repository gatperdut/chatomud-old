module ChatoMud
  module Actions
    class SpawnNpc < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to spawn other NPCs.")

        npc_template_code = @params[:npc_template_code].to_s
        character_outfitter_code = @params[:character_outfitter_code].to_s

        npc_template = CharacterTemplate.find_by_code(npc_template_code)

        return unless check_target_present(npc_template, "Cannot find character template with code '#{npc_template_code}'.")

        character_outfitter = CharacterOutfitter.find_by_code(character_outfitter_code)

        return unless check_target_present(character_outfitter, "Cannot find character outfitter with code '#{character_outfitter_code}'.")

        character_controller = @server.characters_spawner.spawn_npc(npc_template, character_outfitter.item_template_codes, @character_controller.room_controller, { gladiator: false })
        tx("Spawned #{character_controller.short_desc} and outfitted with '#{character_outfitter_code}'.")
      end
    end
  end
end
