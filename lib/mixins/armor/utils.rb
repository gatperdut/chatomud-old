module ChatoMud
  module Mixins
    module Armor
      module Utils
        def maneuver_impediment_factor_for(maneuver_impediment)
          case maneuver_impediment
            when :lowest_mi
              0.125
            when :low_mi
              0.1875
            when :medium_mi
              0.25
            when :high_mi
              0.375
            when :highest_mi
              0.5
            else
              raise "maneuver impediment factor for unknown maneuver impediment"
          end
        end

        def ranged_attack_impediment_factor_for(ranged_impediment)
          case ranged_impediment
            when :no_rai
              0.0
            when :low_rai
              0.125
            when :medium_rai
              0.25
            when :high_rai
              0.5
            else
              raise "ranged impediment factor for unknown ranged impediment"
          end
        end
      end
    end
  end
end
