require "mixins/ink_types/definition"
require "mixins/ink_types/utils"

class WritingImplement < ApplicationRecord
  extend ChatoMud::Mixins::InkTypes::Definition
  include ChatoMud::Mixins::InkTypes::Utils

  belongs_to :item

  enum ink_type: all_ink_types

  validates :item, :ink_type, presence: true

  validates_inclusion_of :charged, :single_use, in: [true, false]

  validate :charged_true_for_picking_ink_types

  validate :ink_type_must_be_picking_if_single_use

  validate :ink_type_must_be_dipping_if_not_single_use

  private

  def charged_true_for_picking_ink_types
    return if is_dipping_ink_type?(ink_type)

    errors.add(:charged, "must be true for picking ink types") unless charged
  end

  def ink_type_must_be_picking_if_single_use
    return unless single_use

    errors.add(:ink_type, "must be a picking ink type if single_use") unless is_picking_ink_type?(ink_type)
  end

  def ink_type_must_be_dipping_if_not_single_use
    return if single_use

    errors.add(:ink_type, "must be a dipping ink_type if not single_use") unless is_dipping_ink_type?(ink_type)
  end
end
