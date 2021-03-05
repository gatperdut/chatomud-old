module ChatoMud
  module Spawners
    module Factories
      class LiquidFuelReqsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(liquid_fuel_req_template)
          liquid_fuel_req_attributes = liquid_fuel_req_template.attributes.symbolize_keys.except(:id, :light_source_template_id)

          liquid_fuel_req = LiquidFuelReq.new(liquid_fuel_req_attributes)

          liquid_fuel_req
        end
      end
    end
  end
end
