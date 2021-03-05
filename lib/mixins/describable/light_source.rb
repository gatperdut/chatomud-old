module ChatoMud
  module Mixins
    module Describable
      module LightSource
        def lifetime_left_approximation
          case lifetime_left
            when 1..300
              "a few more seconds"
            when 301..1800
              "a few more minutes"
            when 1801..3600
              "less than an hour"
            else
              hours = (lifetime_left / 3600.0).floor
              "about #{hours} #{hours > 1 ? 'hours' : 'hour'}"
          end
        end

        def reason_cant_light
          return "it is spent" unless requires_fuel?

          "it requires fuel"
        end
      end
    end
  end
end
