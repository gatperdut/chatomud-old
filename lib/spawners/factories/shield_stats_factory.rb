module ChatoMud
  module Spawners
    module Factories
      class ShieldStatsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(shield_stat_template)
          shield_stat_attributes = shield_stat_template.attributes.symbolize_keys.except(:id, :item_template_id)
          shield_stat = ShieldStat.new(shield_stat_attributes)

          shield_stat
        end
      end
    end
  end
end
