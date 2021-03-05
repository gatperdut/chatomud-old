module ChatoMud
  module Mixins
    module Characters
      module AttributeSet
        module Utils
          module Constitution
            def con_max_wounds_healed_per_pulse
              case attribute_value(:con)
                when  1..10
                  1
                when 11..24
                  2
                when 25..40
                  3
                when 41..59
                  4
                when 60..67
                  5
                when 68..80
                  6
                when 81..90
                  7
                when 91..99
                  8
                when 100
                  9
              end
            end

            def con_max_hits_healed_per_pulse
              case attribute_value(:con)
                when  1..10
                  1
                when 11..40
                  2
                when 41..80
                  3
                when 81..99
                  4
                when 100
                  5
              end
            end
          end
        end
      end
    end
  end
end
