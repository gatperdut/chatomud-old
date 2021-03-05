module ChatoMud
  module Controllers
    module Items
      class MeleeStatController
        def initialize(server, weapon_stat_controller, melee_stat)
          @server = server
          @weapon_stat_controller = weapon_stat_controller
          @melee_stat = melee_stat
        end

        def sheathed_desc
          @melee_stat.sheathed_desc
        end
      end
    end
  end
end
