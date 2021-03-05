require "mixins/armor/definition"

module ChatoMud
  module Spawners
    module Factories
      class ArmorStatsFactory
        include Mixins::Armor::Definition

        def initialize(server)
          @server = server
        end

        def instantiate(armor_stat_template)
          armor_stat_attributes = armor_stat_template.attributes.symbolize_keys.except(:id, :item_template_id)

          armor_stat_attributes[:protection_level] = armor_stat_template.protection_level

          armor_stat_attributes[:penalty_level]    = armor_stat_template.penalty_level

          armor_stat_attributes[:roll_mod]         = armor_stat_template.roll_mod

          armor_stat_attributes[:critical_mod]     = armor_stat_template.critical_mod

          armor_stat = ArmorStat.new(armor_stat_attributes)

          armor_stat
        end
      end
    end
  end
end
