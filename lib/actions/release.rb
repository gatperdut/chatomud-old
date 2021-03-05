module ChatoMud
  module Actions
    class Release < BaseAction
      def exec
        unless entity_controller.possession_controller.is_possessed?
          tx("You are not currently possessing any creature.")
          return
        end

        # interrupt_ranged_weapon_handling

        entity_controller.possession_controller.be_released(:released)
      end
    end
  end
end
