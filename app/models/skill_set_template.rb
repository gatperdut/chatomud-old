require "mixins/characters/skill_set/definition"

class SkillSetTemplate < ApplicationRecord
  include ChatoMud::Mixins::Characters::SkillSet::Definition

  belongs_to :character_template

  serialize :chosen

  validates :character_template, presence: true

  validate :choices_are_valid

  validates :chosen, length: { minimum: 3 }

  private

  def choices_are_valid
    chosen.each do |choice|
      errors.add(:chosen, "invalid choice '#{choice}'") unless all_skills.include?(choice)
    end
  end
end
