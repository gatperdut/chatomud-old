require "mixins/characters/physical_attrs/genders/definition"
require "mixins/characters/physical_attrs/races/definition"
require "mixins/characters/physical_attrs/weight/definition"

class FrameModifier < ApplicationRecord
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Genders::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Races::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Weight::Definition

  enum gender: all_genders

  enum race: all_races

  enum label: all_weight_categories

  validates_uniqueness_of :score_limit, scope: [:gender, :race]

  validates :score_limit, :race, :gender, :label, :modifier, presence: true

  validates :score_limit, numericality: { only_integer: true, less_than_or_equal_to: 100, greater_than_or_equal_to: 1 }
end
