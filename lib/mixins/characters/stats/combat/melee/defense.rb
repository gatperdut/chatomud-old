require "mixins/characters/stats/combat/stances"

module ChatoMud
  module Mixins
    module Characters
      module Stats
        module Combat
          module Melee
            module Defense
              include Mixins::Characters::Stats::Combat::Stances

              def melee_defensive_capability(assailant_controller = nil)
                deflect_mode = @character_controller.combat_controller.melee_deflect_mode

                modifier = block_melee_defensive_modifier(assailant_controller) if deflect_mode == :block

                modifier = parry_melee_defensive_modifier                       if deflect_mode == :parry

                modifier = dodge_melee_defensive_modifier                       if deflect_mode == :dodge

                modifier *= stance_defensive_percentage

                modifier  = modifier.round

                modifier -= flanking_melee_defensive_penalty(assailant_controller)

                modifier -= position_melee_defensive_penalty

                {
                  modifier: modifier,
                  deflect_mode: deflect_mode,
                  armor_penalty_level: inventory_controller.armor_penalty_level
                }
              end

              private

              def parry_melee_defensive_modifier
                parry_skill_modifier = skill_modifier(:parry)

                results = []

                inventory_controller.melee_weapon_controllers(:wielded).each do |melee_weapon_controller|
                  melee_weapon_skill_modifier = skill_modifier(melee_weapon_controller.weapon_stat_controller.skill_name)
                  results << [parry_skill_modifier, melee_weapon_skill_modifier].min
                end

                results.min || 0
              end

              def dodge_melee_defensive_modifier
                return 0 if @character_controller.position_controller.is_sitting_or_resting?

                modifier = skill_modifier(:dodge) - encumbrance_controller.encumbrance_penalty

                [modifier, 0].max
              end

              def block_melee_defensive_modifier(assailant_controller)
                block_skill_modifier = skill_modifier(:block)

                shield_modifier = inventory_controller.shield_item_controllers.map do |item_controller|
                  potential = item_controller.shield_stat_controller.melee_bonus

                  single_modifier = 0
                  if assailant_controller.nil?
                    single_modifier = potential
                  elsif @character_controller.combat_controller.target_is?(assailant_controller)
                    single_modifier = potential
                  else
                    non_target_assailants = @character_controller.combat_controller.non_target_assailants
                    single_modifier = non_target_assailants.index(assailant_controller) < total_non_target_assailants_blocked(item_controller) ? potential : 0
                  end

                  single_modifier
                end.sum

                block_skill_modifier + shield_modifier
              end

              def flanking_melee_defensive_penalty(assailant_controller)
                return 0 if assailant_controller.nil?

                return 0 unless @character_controller.combat_controller.is_attacking?

                return 0 if @character_controller.combat_controller.target_is?(assailant_controller)

                @character_controller.combat_controller.non_target_assailants.count * 7
              end

              def position_melee_defensive_penalty
                return 80 if @character_controller.position_controller.is_resting?
                return 70 if @character_controller.position_controller.is_sitting?

                0
              end

              def total_non_target_assailants_blocked(item_controller)
                value  = item_controller.shield_stat_controller.max_opponents_blocked
                value -= 1 if @character_controller.combat_controller.is_attacking?

                value
              end
            end
          end
        end
      end
    end
  end
end
