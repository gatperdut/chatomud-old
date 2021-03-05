module ChatoMud
  module Spawners
    module Factories
      class InkSourcesFactory
        def initialize(server)
          @server = server
        end

        def instantiate(ink_source_template)
          ink_source_attributes = ink_source_template.attributes.symbolize_keys.except(:id, :item_template_id)

          ink_source = InkSource.new(ink_source_attributes)

          ink_source
        end
      end
    end
  end
end
