module ChatoMud
  module Mixins
    module Characters
      module Stats
        module Combat
          module Stances
            def stance_offensive_percentage
              offensive_percentage_for(@character_controller.choice_controller.stance.to_sym)
            end

            def stance_defensive_percentage
              defensive_percentage_for(@character_controller.choice_controller.stance.to_sym)
            end
          end
        end
      end
    end
  end
end
