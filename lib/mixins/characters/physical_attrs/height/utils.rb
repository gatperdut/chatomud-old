module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Height
          module Utils
            def height_travel_time_multiplier(height)
              case height
                when -Float::INFINITY..69
                  1.8
                when 70..84
                  1.7
                when 85..99
                  1.6
                when 100.114
                  1.5
                when 115..130
                  1.4
                when 131..145
                  1.3
                when 146..160
                  1.2
                when 161..175
                  1.1
                when 176..190
                  1.0
                when 191..206
                  0.9
                when 207..221
                  0.8
                when 222..236
                  0.7
                when 237..Float::INFINITY
                  0.6
              end
            end
          end
        end
      end
    end
  end
end
