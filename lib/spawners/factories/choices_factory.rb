require "mixins/characters/attribute_set/definition"

module ChatoMud
  module Spawners
    module Factories
      class ChoicesFactory
        extend Mixins::Characters::AttributeSet::Definition

        def initialize(server)
          @server = server
        end

        def instantiate(choice_template)
          choice_attributes = choice_template.attributes.symbolize_keys.except(:id, :character_template_id)
          choice = Choice.new(choice_attributes)

          choice
        end
      end
    end
  end
end
