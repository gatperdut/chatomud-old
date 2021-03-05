module ChatoMud
  module Controllers
    module Items
      class ArmorStatController
        def initialize(server, item_controller, armor_stat)
          @server = server
          @item_controller = item_controller
          @armor_stat = armor_stat
        end

        def body_parts
          @armor_stat.body_parts
        end

        def protection_level
          @armor_stat.protection_level
        end

        def penalty_level
          @armor_stat.penalty_level
        end

        def roll_mod
          @armor_stat.roll_mod
        end

        def critical_mod
          @armor_stat.critical_mod
        end

        def maneuver_impediment
          @armor_stat.maneuver_impediment.to_sym
        end

        def ranged_attack_impediment
          @armor_stat.ranged_attack_impediment.to_sym
        end
      end
    end
  end
end
