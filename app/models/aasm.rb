require "mixins/aasm/definition"

class Aasm < ApplicationRecord
  extend ChatoMud::Mixins::Aasm::Definition

  belongs_to :character

  enum code: all_aasm_codes

  validates :code, presence: true

  validates_inclusion_of :active, in: [true, false]

  validate :belongs_only_to_npcs

  private

  def belongs_only_to_npcs
    errors.add(:character_id, "can only belong to NPCs") unless character.is_npc?
  end
end
