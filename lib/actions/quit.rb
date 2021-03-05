module ChatoMud
  module Actions
    class Quit < BaseAction
      def exec
        return unless can_perform?([:in_combat])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to quit.")

        interrupt_ranged_weapon_handling

        @character_controller.entity_controller.handle_leave_game
      end
    end
  end
end
