module ChatoMud
  module Spawners
    module Factories
      class BasicAttributesFactory
        def initialize(server)
          @server = server
        end

        def instantiate(item_template)
          basic_attributes = item_template.attributes.symbolize_keys.except(:id, :code)

          basic_attributes
        end
      end
    end
  end
end
