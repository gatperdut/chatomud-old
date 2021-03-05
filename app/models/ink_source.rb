require "mixins/ink_types/definition"
require "mixins/ink_types/utils"

class InkSource < ApplicationRecord
  extend ChatoMud::Mixins::InkTypes::Definition
  include ChatoMud::Mixins::InkTypes::Utils

  belongs_to :item

  belongs_to :spawned_item_template, class_name: "ItemTemplate", optional: true

  enum ink_type: all_ink_types

  validates :ink_type, :charges, :item, presence: true

  validates :charges, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :spawned_item_template_set_if_ink_type_is_picking

  validate :spawned_item_template_nil_if_ink_type_is_dipping

  validate :spawned_item_template_is_actually_that

  private

  def spawned_item_template_set_if_ink_type_is_picking
    return if spawned_item_template

    errors.add(:spawned_item_template, "must be present for 'picking' ink types") if is_picking_ink_type?(ink_type)
  end

  def spawned_item_template_nil_if_ink_type_is_dipping
    return unless spawned_item_template

    errors.add(:spawned_item_template, "must be nil for 'dipping' ink types") if is_dipping_ink_type?(ink_type)
  end

  def spawned_item_template_is_actually_that
    return unless spawned_item_template

    errors.add(:spawned_item_template, "must be a writing implement template") unless spawned_item_template.is_writing_implement_template?
  end
end
