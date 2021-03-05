require "mixins/characters/attribute_set/definition"

class AttributeSetTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Characters::AttributeSet::Definition

  belongs_to :character_template

  serialize :preference

  validates :character_template, presence: true

  validates :preference, length: { minimum: 7, maximum: 7 }

  validate :each_attribute_present_once

  private

  def each_attribute_present_once
    self.class.all_attributes.each do |attribute|
      errors.add(:preference, "#{attribute} is not present") unless preference.include?(attribute)
    end
  end
end
