require "mixins/characters/skill_set/definition"

class CategoryRank < ApplicationRecord
  extend ChatoMud::Mixins::Characters::SkillSet::Definition

  enum rate: all_category_rank_rates

  validates :value, :bonus, :rate, presence: true

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 30 }

  def unskilled?
    value.zero?
  end
end
