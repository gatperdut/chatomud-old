module ChatoMud
  module Mixins
    module Characters
      module Choices
        module Stances
          module Utils
            def offensive_percentage_for(stance)
              case stance
                when :pacifist
                  0.0
                when :defensive
                  0.16
                when :careful
                  0.335
                when :normal
                  0.5
                when :aggressive
                  0.665
                when :frantic
                  0.84
                when :frenzy
                  1.0
                else
                  raise "Unknown stance '#{stance}'"
              end
            end

            def defensive_percentage_for(stance)
              case stance
                when :pacifist
                  1.0
                when :defensive
                  0.84
                when :careful
                  0.665
                when :normal
                  0.5
                when :aggressive
                  0.335
                when :frantic
                  0.16
                when :frenzy
                  0.0
                else
                  raise "Unknown stance '#{stance}'"
              end
            end
          end
        end
      end
    end
  end
end
