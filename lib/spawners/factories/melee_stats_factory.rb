module ChatoMud
  module Spawners
    module Factories
      class MeleeStatsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(melee_stat_template)
          melee_stat_attributes = melee_stat_template.attributes.symbolize_keys.except(:id, :weapon_stat_template_id)
          melee_stat = MeleeStat.new(melee_stat_attributes)

          melee_stat
        end
      end
    end
  end
end
