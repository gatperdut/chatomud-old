module ChatoMud
  module Periodic
    module Tasks
      class FuelConsumptionPulse
        def initialize(server)
          @server = server
        end

        def tick
          @server.items_handler.light_source_controllers.each do |light_source_controller|
            light_source_controller.light_source_controller.reduce_lifetime
          end
        end
      end
    end
  end
end
