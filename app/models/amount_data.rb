require "mixins/fluids/definition"

class AmountData < ApplicationRecord
  extend ChatoMud::Mixins::Fluids::Definition

  belongs_to :amount, optional: true

  enum fluid: all_fluids
end
