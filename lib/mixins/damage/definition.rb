module ChatoMud
  module Mixins
    module Damage
      module Definition
        def all_critical_severities
          [
            :A,
            :B,
            :C,
            :D,
            :E
          ]
        end

        def all_critical_types
          [
            :crush,
            :puncture,
            :slash,
            :hand_to_hand
          ]
        end

        def all_attack_stun_types
          [
            :no_attack,
            :attack_penalty
          ]
        end

        def all_parry_stun_types
          [
            :no_parry,
            :parry_penalty
          ]
        end
      end
    end
  end
end
