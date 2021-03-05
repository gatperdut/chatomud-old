module ChatoMud
  module Referrers
    class SkillReferrer
      def initialize
        @entries = Skill.all.to_a
      end

      def find(skill_name)
        @entries.select do |entry|
          entry.name.to_sym == skill_name
        end.first
      end

      def group_by(skill_category)
        @entries.select do |entry|
          entry.skill_category.to_sym == skill_category
        end
      end
    end
  end
end
