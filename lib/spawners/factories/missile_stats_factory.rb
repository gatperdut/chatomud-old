module ChatoMud
  module Spawners
    module Factories
      class MissileStatsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(missile_stat_template)
          missile_stat_attributes = missile_stat_template.attributes.symbolize_keys.except(:id, :item_template_id)
          missile_stat = MissileStat.new(missile_stat_attributes)

          missile_stat
        end
      end
    end
  end
end
