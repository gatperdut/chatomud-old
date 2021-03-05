require "mixins/characters/skill_set/definition"
require "mixins/characters/attribute_set/definition"

class SkillCategory < ApplicationRecord
  extend ChatoMud::Mixins::Characters::SkillSet::Definition
  extend ChatoMud::Mixins::Characters::AttributeSet::Definition

  enum name: all_skill_categories

  serialize :dependencies

  validates :name, presence: true

  validates :name, uniqueness: true

  validates :dependencies, length: { is: 3 }

  validate :dependencies_are_valid

  private

  def dependencies_are_valid
    dependencies.each do |dependency|
      errors.add(:dependencies, "invalid dependency '#{dependency}'") unless self.class.all_attributes.include?(dependency)
    end
  end
end
