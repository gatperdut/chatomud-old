class InventoryTemplate < ApplicationRecord
  has_one :lid_template, dependent: :destroy

  has_one :inventory_template, as: :parent, dependent: :destroy, inverse_of: :parent

  belongs_to :parent, polymorphic: true

  validate :only_item_and_furniture_templates_can_have_lids

  validate :sheaths_and_quivers_cannot_have_lids

  validates_associated :lid_template, :inventory_template

  accepts_nested_attributes_for :lid_template

  def belongs_to_item_template?
    parent_type == "ItemTemplate"
  end

  def belongs_to_furniture_template?
    parent_type == "FurnitureTemplate"
  end

  def belongs_to_item_or_furniture_template?
    belongs_to_item_template? || belongs_to_furniture_template?
  end

  private

  def only_item_and_furniture_templates_can_have_lids
    errors.add(:lid_template, "only item template inventories can have lid templates") if lid_template && !belongs_to_item_or_furniture_template?
  end

  def sheaths_and_quivers_cannot_have_lids
    errors.add(:lid_template, "sheaths and quivers cannot have lids") if lid_template && belongs_to_item_template? && (parent.is_sheath || parent.is_quiver)
  end
end
