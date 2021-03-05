require "mixins/characters/physical_attrs/height/definition"
require "mixins/characters/physical_attrs/races/definition"

class BaseFrame < ApplicationRecord
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Height::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Races::Definition

  enum race: all_races

  enum label: all_height_categories

  validates_uniqueness_of :score_limit, :column, scope: :race

  validates :score_limit, :race, :height, :weight, :label, presence: true

  validates :score_limit, numericality: { only_integer: true, less_than_or_equal_to: 320, greater_than_or_equal_to: -191 }

  validates :column, numericality: { only_integer: true, less_than_or_equal_to: 26, greater_than_or_equal_to: 0 }

  validates :height, :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
