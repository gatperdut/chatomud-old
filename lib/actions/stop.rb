module ChatoMud
  module Actions
    class Stop < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        return if interrupt_transient_ranged_weapon_handling

        return if interrupt_static_ranged_weapon_handling

        if @character_controller.crafts_controller.is_crafting?
          @character_controller.crafts_controller.stop_crafting(true)
          return
        end

        if @character_controller.combat_controller.is_fleeing?
          @character_controller.combat_controller.stop_fleeing(true)
          return
        end

        if @character_controller.combat_controller.is_attacking?
          @character_controller.combat_controller.stop_combat(true, true)
          return
        end

        tx("You are not performing any specific activity.")
      end
    end
  end
end
