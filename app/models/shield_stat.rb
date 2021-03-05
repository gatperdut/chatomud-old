require "mixins/shield/definition"

class ShieldStat < ApplicationRecord
  extend ChatoMud::Mixins::Shield::Definition

  belongs_to :item

  enum variant: all_variants

  validates :item, :variant, :quality_modifier, presence: true
end
