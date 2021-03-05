require "mixins/shield/utils"

module ChatoMud
  module Controllers
    module Items
      class ShieldStatController
        include Mixins::Shield::Utils

        def initialize(server, item_controller, shield_stat)
          @server = server
          @item_controller = item_controller
          @shield_stat = shield_stat
        end

        def melee_bonus
          melee_bonus_for(variant.to_sym) + quality_modifier
        end

        def ranged_bonus
          ranged_bonus_for(variant.to_sym) + quality_modifier
        end

        def variant
          @shield_stat.variant
        end

        def quality_modifier
          @shield_stat.quality_modifier
        end

        def max_opponents_blocked
          max_opponents_blocked_for(variant.to_sym)
        end
      end
    end
  end
end
