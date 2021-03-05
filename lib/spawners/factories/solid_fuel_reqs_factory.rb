module ChatoMud
  module Spawners
    module Factories
      class SolidFuelReqsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(solid_fuel_req_template)
          solid_fuel_req_attributes = solid_fuel_req_template.attributes.symbolize_keys.except(:id, :light_source_template_id)

          solid_fuel_req_attributes[:options] = solid_fuel_req_template.options

          solid_fuel_req = SolidFuelReq.new(solid_fuel_req_attributes)

          solid_fuel_req
        end
      end
    end
  end
end
