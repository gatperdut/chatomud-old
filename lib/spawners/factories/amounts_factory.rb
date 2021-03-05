module ChatoMud
  module Spawners
    module Factories
      class AmountsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(amount_template)
          amount_attributes = amount_template.attributes.symbolize_keys.except(:id, :stackable_id, :edible_id, :fillable_id, :fuelable_id)

          amount_attributes[:amount_data] = @server.amount_data_factory.instantiate(amount_template.amount_data_template) if amount_template.amount_data_template

          amount = Amount.new(amount_attributes)

          amount
        end
      end
    end
  end
end
