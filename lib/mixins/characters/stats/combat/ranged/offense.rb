require "mixins/characters/skill_set/utils"

module ChatoMud
  module Mixins
    module Characters
      module Stats
        module Combat
          module Ranged
            module Offense
              include Mixins::Characters::SkillSet::Utils

              def ranged_offensive_capability
                item_controller = inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

                return nil if item_controller.nil?

                base         = item_controller.weapon_stat_controller.base

                skill_name   = item_controller.weapon_stat_controller.skill_name

                modifier     = skill_modifier(skill_name)

                modifier    += item_controller.weapon_stat_controller.roll_mod

                modifier    -= armor_ranged_penalty

                modifier    -= health_controller.exhaustion_penalty

                modifier    -= nourishment_controller.penalty

                critical_mod = item_controller.weapon_stat_controller.critical_mod

                {
                  controller:   item_controller,
                  base:         base,
                  skill_name:   skill_name,
                  modifier:     modifier,
                  critical_mod: critical_mod
                }
              end
            end
          end
        end
      end
    end
  end
end
