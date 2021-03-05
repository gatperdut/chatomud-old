module ChatoMud
  module Spawners
    module Factories
      class AmountDataFactory
        def initialize(server)
          @server = server
        end

        def instantiate(amount_data_template)
          amount_data_attributes = amount_data_template.attributes.symbolize_keys.except(:id, :amount_template_id)

          amount_data = AmountData.new(amount_data_attributes)

          amount_data
        end
      end
    end
  end
end
