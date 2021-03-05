require "mixins/characters/skill_set/definition"

class SkillSet < ApplicationRecord
  extend ChatoMud::Mixins::Characters::SkillSet::Definition

  belongs_to :character

  validates :character, presence: true

  validates(*all_skills_and_skill_categories, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 })
end
