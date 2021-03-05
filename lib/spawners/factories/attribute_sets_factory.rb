require "mixins/characters/attribute_set/definition"

module ChatoMud
  module Spawners
    module Factories
      class AttributeSetsFactory
        extend Mixins::Characters::AttributeSet::Definition

        def initialize(server)
          @server = server
        end

        def instantiate(_attribute_set_template)
          attribute_set = AttributeSet.new

          # use attribute_set_template.preference instead of totally random
          self.class.all_attributes.each do |stat|
            attribute_set.send("#{stat}=", rand(1..100))
          end

          attribute_set
        end
      end
    end
  end
end
