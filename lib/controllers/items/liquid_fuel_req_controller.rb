module ChatoMud
  module Controllers
    module Items
      class LiquidFuelReqController
        def initialize(server, light_source_controller, liquid_fuel_req)
          @server = server
          @light_source_controller = light_source_controller
          @liquid_fuel_req = liquid_fuel_req
        end

        def is_valid_fuel?(fluid)
          @liquid_fuel_req.options.include?(fluid.to_sym)
        end
      end
    end
  end
end
