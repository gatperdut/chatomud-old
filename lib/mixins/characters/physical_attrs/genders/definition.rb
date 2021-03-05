module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Genders
          module Definition
            def all_genders
              [
                :male,
                :female,
                :neuter
              ]
            end

            def gender_caloric_needs_multiplier
              {
                male:   1.0,
                female: 0.8,
                neuter: 1.0
              }
            end
          end
        end
      end
    end
  end
end
