module ChatoMud
  module Controllers
    module Characters
      class PhysicalAttrController
        def initialize(server, character_controller, physical_attr)
          @server = server
          @character_controller = character_controller
          @physical_attr = physical_attr
        end

        def gender
          @physical_attr.gender.to_sym
        end

        def race
          @physical_attr.race.to_sym
        end

        def height
          @physical_attr.height
        end

        def height_approximation
          round_to_multiple(height, 3)
        end

        def weight
          @physical_attr.weight
        end

        def weight_approximation
          round_to_multiple(weight, 5)
        end

        private

        def round_to_multiple(number, multiple_of)
          (number / multiple_of.to_f).round * multiple_of
        end
      end
    end
  end
end
