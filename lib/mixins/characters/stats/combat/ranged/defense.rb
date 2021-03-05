module ChatoMud
  module Mixins
    module Characters
      module Stats
        module Combat
          module Ranged
            module Defense
              def ranged_defensive_capability
                deflect_mode = @character_controller.combat_controller.ranged_deflect_mode

                modifier = send("#{deflect_mode}_ranged_defensive_modifier")

                modifier *= combat_controller.is_in_combat? ? stance_defensive_percentage : 1.0

                modifier  = modifier.round

                modifier -= position_ranged_defensive_penalty

                {
                  modifier: modifier,
                  deflect_mode: deflect_mode,
                  armor_penalty_level: inventory_controller.armor_penalty_level
                }
              end

              private

              def parry_ranged_defensive_modifier
                parry_skill_modifier = skill_modifier(:parry)

                results = []

                inventory_controller.melee_weapon_controllers(:wielded).each do |melee_weapon_controller|
                  melee_weapon_skill_modifier = skill_modifier(melee_weapon_controller.weapon_stat_controller.skill_name)
                  results << [parry_skill_modifier, melee_weapon_skill_modifier].min
                end

                (results.sum * 0.05).round
              end

              def block_ranged_defensive_modifier
                block_skill_modifier = skill_modifier(:block)

                shield_modifier = inventory_controller.shield_item_controllers.map do |item_controller|
                  item_controller.shield_stat_controller.ranged_bonus
                end.sum

                multiplier = @character_controller.combat_controller.is_in_combat? ? 0.5 : 1.0

                ((block_skill_modifier + shield_modifier) * multiplier).round
              end

              def dodge_ranged_defensive_modifier
                return 0 if @character_controller.position_controller.is_sitting_or_resting?

                modifier = skill_modifier(:dodge) - encumbrance_controller.encumbrance_penalty

                [modifier, 0].max
              end

              def position_ranged_defensive_penalty
                return 50 if @character_controller.position_controller.is_resting?

                return 60 if @character_controller.position_controller.is_sitting?

                0
              end
            end
          end
        end
      end
    end
  end
end
