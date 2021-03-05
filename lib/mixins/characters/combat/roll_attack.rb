module ChatoMud
  module Mixins
    module Characters
      module Combat
        module RollAttack
          def roll_attack(offensive_capability, defensive_capability, body_part)
            roll  = d100

            roll += offensive_capability[:modifier]

            roll -= defensive_capability[:modifier]

            armor = inventory_controller.armor_for(body_part)

            maximum_miss_score_protection = attack_referrer.maximum_miss_score(offensive_capability[:skill_name], armor[:protection_level])

            roll -= armor[:modifiers][:roll]

            contact_attack = attack_referrer.find(offensive_capability[:skill_name], roll, defensive_capability[:armor_penalty_level])

            if contact_attack.connects
              attack = attack_referrer.find(offensive_capability[:skill_name], [roll, maximum_miss_score_protection + 1].max, armor[:protection_level])
            else
              attack = contact_attack
            end

            attack
          end
        end
      end
    end
  end
end
