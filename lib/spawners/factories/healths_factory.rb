module ChatoMud
  module Spawners
    module Factories
      class HealthsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(health_template, attribute_set)
          health_attributes = health_template.attributes.symbolize_keys.except(:id, :character_template_id)

          health = Health.new(health_attributes)

          health.exhaustion = attribute_set.con

          health
        end
      end
    end
  end
end
