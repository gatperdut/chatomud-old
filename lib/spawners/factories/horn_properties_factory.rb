module ChatoMud
  module Spawners
    module Factories
      class HornPropertiesFactory
        def initialize(server)
          @server = server
        end

        def instantiate(horn_property_template)
          horn_property_attributes = horn_property_template.attributes.symbolize_keys.except(:id, :item_template_id)
          horn_property = HornProperty.new(horn_property_attributes)

          horn_property
        end
      end
    end
  end
end
