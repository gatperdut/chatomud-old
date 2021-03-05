module ChatoMud
  module Periodic
    module Tasks
      class NourishmentBurner
        def initialize(server)
          @server = server
        end

        def tick
          @server.characters_handler.pc_controllers.each do |character_controller|
            character_controller.nourishment_controller.auto_burn_nourishment
          end
        end
      end
    end
  end
end
