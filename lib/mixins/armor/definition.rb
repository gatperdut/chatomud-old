module ChatoMud
  module Mixins
    module Armor
      module Definition
        def all_maneuver_impediments
          [
            :lowest_mi, #   1/8 head or single upper limb
            :low_mi,    # 1.5/8 single lower limb
            :medium_mi, #   2/8 both upper limbs
            :high_mi,   #   3/8 both lower limbs
            :highest_mi #   4/8 torso
          ]
        end

        def all_ranged_attack_impediments
          [
            :no_rai,     # 0/8 not in upper limbs
            :low_rai,    # 1/8 single upper limb
            :medium_rai, # 2/8 both upper limbs
            :high_rai    # 4/8 hands
          ]
        end
      end
    end
  end
end
