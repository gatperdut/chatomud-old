module ChatoMud
  module Spawners
    module Factories
      class LocksFactory
        def initialize(server)
          @server = server
        end

        def instantiate(lock_template)
          lock_attributes = lock_template.attributes.symbolize_keys.except(:id, :parent_id, :parent_type)

          lock = Lock.new(lock_attributes)

          lock
        end
      end
    end
  end
end
