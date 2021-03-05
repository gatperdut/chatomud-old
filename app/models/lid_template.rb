class LidTemplate < ApplicationRecord
  belongs_to :inventory_template

  has_one :lock_template, as: :parent, dependent: :destroy, inverse_of: :parent

  validate :can_only_belong_to_item_or_furniture_template_inventory

  validates_associated :lock_template

  accepts_nested_attributes_for :lock_template

  private

  def can_only_belong_to_item_or_furniture_template_inventory
    errors.add(:inventory_template, "can only be an item inventory template") unless inventory_template.belongs_to_item_or_furniture_template?
  end
end
