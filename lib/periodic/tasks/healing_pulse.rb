module ChatoMud
  module Periodic
    module Tasks
      class HealingPulse
        def initialize(server)
          @server = server
        end

        def tick
          @server.characters_handler.character_controllers.each do |character_controller|
            character_controller.health_controller.heal

            character_controller.health_controller.catch_breath
          end
        end
      end
    end
  end
end
