module ChatoMud
  module Mixins
    module Fluids
      module Definition
        def all_fluids
          [
            :water,
            :wine,
            :beer,
            :oil
          ]
        end

        def fluid_color
          {
            water: :blue,
            beer:  :yellow,
            wine:  :magenta,
            oil:   :cyan
          }
        end

        def is_fluid_drinkable?
          {
            water: true,
            beer:  true,
            wine:  true,
            oil:   false
          }
        end
      end
    end
  end
end
