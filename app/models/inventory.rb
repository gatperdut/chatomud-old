class Inventory < ApplicationRecord
  has_one :lid, dependent: :destroy

  belongs_to :parent, polymorphic: true

  has_many :items, dependent: :destroy, foreign_key: "containing_inventory_id"

  validate :only_items_and_furniture_can_have_lids

  validate :sheaths_ranged_weapons_and_quivers_cannot_have_lids

  validates :parent, presence: true

  validates_associated :lid, :items

  accepts_nested_attributes_for :lid

  def belongs_to_room?
    parent_type == "Room"
  end

  def belongs_to_furniture?
    parent_type == "Furniture"
  end

  def belongs_to_character?
    parent_type == "Character"
  end

  def belongs_to_item?
    parent_type == "Item"
  end

  def belongs_to_item_or_furniture?
    belongs_to_item? || belongs_to_furniture?
  end

  private

  def only_items_and_furniture_can_have_lids
    errors.add(:lid, "only item or furniture inventories can have lids") if lid && !belongs_to_item_or_furniture?
  end

  def sheaths_ranged_weapons_and_quivers_cannot_have_lids
    errors.add(:lid, "sheaths and quivers cannot have lids") if lid && belongs_to_item? && (parent.is_sheath || parent.is_quiver || parent.is_ranged_weapon?)
  end
end
