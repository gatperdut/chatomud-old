module ChatoMud
  module Spawners
    module Factories
      class LidsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(lid_template)
          lid_attributes = lid_template.attributes.symbolize_keys.except(:id, :inventory_template_id)
          lid = Lid.new(lid_attributes)

          lid.lock = @server.locks_factory.instantiate(lid_template.lock_template) if lid_template.lock_template

          lid
        end
      end
    end
  end
end
