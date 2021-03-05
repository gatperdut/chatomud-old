module ChatoMud
  module Spawners
    module Factories
      class LightSourcesFactory
        def initialize(server)
          @server = server
        end

        def instantiate(light_source_template)
          light_source_attributes = light_source_template.attributes.symbolize_keys.except(:id, :item_template_id)

          light_source = LightSource.new(light_source_attributes)

          light_source.solid_fuel_req  = @server.solid_fuel_reqs_factory.instantiate(light_source_template.solid_fuel_req_template)   if light_source_template.solid_fuel_req_template
          light_source.liquid_fuel_req = @server.liquid_fuel_reqs_factory.instantiate(light_source_template.liquid_fuel_req_template) if light_source_template.liquid_fuel_req_template

          light_source.capacity = @server.amounts_factory.instantiate(light_source_template.capacity) if light_source_template.capacity

          light_source
        end
      end
    end
  end
end
