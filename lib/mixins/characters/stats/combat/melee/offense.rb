require "mixins/characters/stats/combat/stances"
require "mixins/characters/skill_set/utils"

module ChatoMud
  module Mixins
    module Characters
      module Stats
        module Combat
          module Melee
            module Offense
              include Mixins::Characters::Stats::Combat::Stances
              include Mixins::Characters::SkillSet::Utils

              def melee_offensive_capabilities
                item_controllers = inventory_controller.melee_weapon_controllers(:wielded)

                if item_controllers.empty?
                  return [
                    {
                      controller:   nil,
                      desc:         "fist",
                      base:         :brawl,
                      skill_name:   :brawl,
                      modifier:     (skill_modifier(:brawl) * stance_offensive_percentage).round,
                      critical_mod: 0
                    }
                  ]
                end

                capabilities = []

                item_controllers.each_with_index do |item_controller, index|
                  base         = item_controller.weapon_stat_controller.base

                  skill_name   = item_controller.weapon_stat_controller.skill_name

                  modifier     = skill_melee_offensive_modifier(item_controller.weapon_stat_controller.skill_name)

                  modifier    *= stance_offensive_percentage

                  modifier     = modifier.round

                  modifier    += item_controller.weapon_stat_controller.roll_mod

                  modifier    -= health_controller.exhaustion_penalty

                  modifier    -= nourishment_controller.penalty

                  critical_mod = item_controller.weapon_stat_controller.critical_mod

                  capabilities << {
                    controller:   item_controller,
                    base:         base,
                    skill_name:   skill_name,
                    modifier:     modifier,
                    critical_mod: critical_mod
                  }
                end

                capabilities
              end

              private

              def skill_melee_offensive_modifier(skill_name)
                modifier = skill_modifier(skill_name)

                modifier = [modifier, skill_modifier(:dual_wield)].min if inventory_controller.is_dual_wielding?

                modifier
              end
            end
          end
        end
      end
    end
  end
end
