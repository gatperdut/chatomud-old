module ChatoMud
  module Mixins
    module Fluids
      module Utils
        def fluid_weight_per_unit(fluid)
          case fluid.to_sym
            when :water
              200
            when :wine
              198
            when :beer
              212
            when :oil
              180
            else
              raise "Invalid fluid when determining fluid weight per unit."
          end
        end

        def fluid_calories_per_unit(fluid)
          case fluid.to_sym
            when :water
              0
            when :wine
              5
            when :beer
              10
            else
              raise "Invalid fluid when determining fluid calories per unit"
          end
        end

        def fluid_hydration_per_unit(fluid)
          case fluid.to_sym
            when :water
              50
            when :wine
              45
            when :beer
              40
            else
              raise "Invalid fluid when determining fluid calories per unit"
          end
        end
      end
    end
  end
end
