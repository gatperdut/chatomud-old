require "mixins/missile/definition"

class MissileStatTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Missile::Definition

  belongs_to :item_template

  enum missile_type: all_missile_types

  validates :missile_type, :item_template, presence: true

  validates :item_template, presence: true
end
