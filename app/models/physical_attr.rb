require "mixins/characters/physical_attrs/genders/definition"
require "mixins/characters/physical_attrs/races/definition"

class PhysicalAttr < ApplicationRecord
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Genders::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Races::Definition

  belongs_to :character

  enum gender: all_genders

  enum race: all_races

  validates :character, :gender, :height, :weight, :race, presence: true

  validates :height, :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
