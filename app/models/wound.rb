require "mixins/body_parts/definition"
require "mixins/damage/definition"

class Wound < ApplicationRecord
  extend ChatoMud::Mixins::BodyParts::Definition
  extend ChatoMud::Mixins::Damage::Definition

  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  belongs_to :health

  enum damage_type: all_critical_types

  enum body_part: all_body_parts

  validates :health, :damage, :damage_type, :body_part, presence: true

  validate :it_holds_maximum_one_missile

  validates_associated :inventory

  private

  def it_holds_maximum_one_missile
    return unless inventory

    items = inventory.items

    errors.add(:inventory, "wound inventories can hold only one item") if items.length > 1

    item = items[0]

    return unless item

    return if item.is_missile?

    errors.add(:inventory, "wound inventories can only hold one missile")
  end
end
