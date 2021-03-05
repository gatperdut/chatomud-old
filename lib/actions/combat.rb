require "mixins/characters/choices/stances/utils"

module ChatoMud
  module Actions
    class Combat < BaseAction
      include Mixins::Characters::Choices::Stances::Utils

      def exec
        text = ""

        text << "\nMelee offensive:\n"
        text << "#{melee_offensive_summary}\n"

        text << "\nMelee defensive:\n"
        text << "#{melee_defensive_summary}\n"

        text << "\nRanged offensive:\n"
        text << "#{ranged_offensive_summary}\n"

        text << "\nRanged defensive:\n"
        text << "#{ranged_defensive_summary}\n"

        tx(text)
      end

      private

      def melee_offensive_summary
        @character_controller.stats_controller.melee_offensive_capabilities.map do |moc|
          moc.except(:controller)
        end
      end

      def melee_defensive_summary
        @character_controller.stats_controller.melee_defensive_capability
      end

      def ranged_offensive_summary
        ranged_offensive_capability = @character_controller.stats_controller.ranged_offensive_capability

        return "" if ranged_offensive_capability.nil?

        ranged_offensive_capability.except(:controller)
      end

      def ranged_defensive_summary
        @character_controller.stats_controller.ranged_defensive_capability
      end
    end
  end
end
