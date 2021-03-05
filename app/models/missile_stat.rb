require "mixins/missile/definition"

class MissileStat < ApplicationRecord
  extend ChatoMud::Mixins::Missile::Definition

  belongs_to :item

  enum missile_type: all_missile_types

  validates :missile_type, :item, presence: true
end
