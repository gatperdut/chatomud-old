require "mixins/fluids/definition"

class AmountDataTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Fluids::Definition

  belongs_to :amount_template, optional: true

  enum fluid: all_fluids
end
