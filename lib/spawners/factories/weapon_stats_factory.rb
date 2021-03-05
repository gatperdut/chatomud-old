module ChatoMud
  module Spawners
    module Factories
      class WeaponStatsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(weapon_stat_template)
          weapon_stat_attributes = weapon_stat_template.attributes.symbolize_keys.except(:id, :item_template_id)

          weapon_stat_attributes[:roll_mod]     = weapon_stat_template.roll_mod

          weapon_stat_attributes[:critical_mod] = weapon_stat_template.critical_mod

          weapon_stat = WeaponStat.new(weapon_stat_attributes)

          weapon_stat.melee_stat  = @server.melee_stats_factory.instantiate(weapon_stat_template.melee_stat_template) if weapon_stat_template.melee_stat_template
          weapon_stat.ranged_stat = @server.ranged_stats_factory.instantiate(weapon_stat_template.ranged_stat_template) if weapon_stat_template.ranged_stat_template

          weapon_stat
        end
      end
    end
  end
end
