module ChatoMud
  module Spawners
    module Factories
      class NourishmentsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(_physical_attr)
          # TODO: Use physical_attr to determine starting calories and hydration - it should match the maximum by race and gender.
          nourishment = Nourishment.new(
            calories:  1000,
            hydration: 1000
          )

          nourishment
        end
      end
    end
  end
end
