module ChatoMud
  module Controllers
    module Characters
      class VisibilityController
        attr_reader :visible

        def initialize(server, character_controller)
          @server               = server
          @character_controller = character_controller
          @visible              = true
        end

        def is_visible?
          @visible == true
        end

        def is_invisible?
          !is_visible?
        end

        def turn(value)
          @visible = value
        end
      end
    end
  end
end
