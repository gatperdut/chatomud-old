module ChatoMud
  module Spawners
    module Factories
      class RangedStatsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(ranged_stat_template)
          ranged_stat_attributes = ranged_stat_template.attributes.symbolize_keys.except(:id, :weapon_stat_template_id)
          ranged_stat = RangedStat.new(ranged_stat_attributes)

          ranged_stat.inventory = @server.inventories_factory.instantiate(ranged_stat_template.inventory_template)

          ranged_stat
        end
      end
    end
  end
end
