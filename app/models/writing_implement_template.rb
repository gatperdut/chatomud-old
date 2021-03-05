require "mixins/ink_types/definition"
require "mixins/ink_types/utils"

class WritingImplementTemplate < ApplicationRecord
  extend ChatoMud::Mixins::InkTypes::Definition
  include ChatoMud::Mixins::InkTypes::Utils

  belongs_to :item_template

  validates :item_template, presence: true

  validates_inclusion_of :single_use, in: [true, false]
end
