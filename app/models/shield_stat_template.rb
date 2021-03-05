require "mixins/shield/definition"

class ShieldStatTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Shield::Definition

  belongs_to :item_template

  validates :item_template, :variant, :quality_modifier, presence: true

  enum variant: all_variants
end
