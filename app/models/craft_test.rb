require "mixins/characters/skill_set/definition"

class CraftTest < ApplicationRecord
  extend ChatoMud::Mixins::Characters::SkillSet::Definition

  belongs_to :craft_step

  enum skill: all_skills

  validates :modifier, numericality: { only_integer: true, greater_than: -100, less_than: 100 }

  validates :skill, :modifier, presence: true
end
