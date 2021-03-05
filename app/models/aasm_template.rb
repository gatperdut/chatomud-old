require "mixins/aasm/definition"

class AasmTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Aasm::Definition

  belongs_to :character_template

  enum code: all_aasm_codes

  validates :code, :character_template, presence: true
end
