require "mixins/characters/skill_set/definition"

module ChatoMud
  module Spawners
    module Factories
      class SkillSetsFactory
        extend Mixins::Characters::SkillSet::Definition

        def initialize(server)
          @server = server
        end

        def instantiate(_skill_set_template)
          skill_set = SkillSet.new

          # use skill_set_template.chosen instead of totally random
          self.class.all_skills_and_skill_categories.each do |skill|
            skill_set.send("#{skill}=", rand(0..30))
          end

          skill_set
        end
      end
    end
  end
end
