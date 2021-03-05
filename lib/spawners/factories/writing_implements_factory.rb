module ChatoMud
  module Spawners
    module Factories
      class WritingImplementsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(writing_implement_template)
          writing_implement_attributes = writing_implement_template.attributes.symbolize_keys.except(:id, :item_template_id)

          single_use = writing_implement_attributes[:single_use]

          writing_implement_attributes[:charged] = single_use

          writing_implement_attributes[:ink_type] = single_use ? :chalk : :black_ink

          writing_implement = WritingImplement.new(writing_implement_attributes)

          writing_implement
        end
      end
    end
  end
end
