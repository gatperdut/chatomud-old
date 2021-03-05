module ChatoMud
  module Referrers
    class SkillCategoryReferrer
      def initialize
        @entries = SkillCategory.all.to_a
      end

      def find(skill_category_name)
        @entries.select do |entry|
          entry.name.to_sym == skill_category_name
        end.first
      end
    end
  end
end
