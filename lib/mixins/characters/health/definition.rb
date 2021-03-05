module ChatoMud
  module Mixins
    module Characters
      module Health
        module Definition
          def hits_accrue_goal
            {
              standing: 200,
              sitting:  170,
              resting:  160,
              sleeping: 120
            }
          end

          def exhaustion_accrue_goal
            {
              standing: 6,
              sitting:  5,
              resting:  2,
              sleeping: 1
            }
          end

          def exhaustion_recovery
            {
              standing: 1,
              sitting:  2,
              resting:  2,
              sleeping: 3
            }
          end
        end
      end
    end
  end
end
