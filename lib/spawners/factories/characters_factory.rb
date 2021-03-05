module ChatoMud
  module Spawners
    module Factories
      class CharactersFactory
        def initialize(server)
          @server = server
        end

        def instantiate(character_template)
          basic_attributes = character_template.attributes.symbolize_keys.except(:id, :code, :names, :noun, :short_descs, :long_desc_endings)

          character = Character.new(basic_attributes)

          character.inventory = Inventory.new

          character.physical_attr = @server.physical_attrs_factory.instantiate(character_template.physical_attr_template)

          # character.nourishment = @server.nourishments_factory.instantiate(character.physical_attr)

          character.attribute_set = @server.attribute_sets_factory.instantiate(character_template.attribute_set_template)

          character.skill_set = @server.skill_sets_factory.instantiate(character_template.skill_set_template)

          character.aasm = Aasm.new(code: :aggro, active: true)

          character.choice = @server.choices_factory.instantiate(character_template.choice_template)

          character.health = @server.healths_factory.instantiate(character_template.health_template, character.attribute_set)

          character
        end
      end
    end
  end
end
