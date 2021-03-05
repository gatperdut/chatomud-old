class Room < ApplicationRecord
  before_validation :set_default_associations, on: :create

  before_destroy :check_no_characters

  before_destroy :check_no_items

  before_destroy :check_no_furniture

  before_destroy :abort_if_necessary

  before_destroy -> { anchor(true) }

  belongs_to :area

  has_one :nr,  class_name: "Room", foreign_key: "sr_id",  inverse_of: :sr

  has_one :er,  class_name: "Room", foreign_key: "wr_id",  inverse_of: :wr

  has_one :sr,  class_name: "Room", foreign_key: "nr_id",  inverse_of: :nr

  has_one :wr,  class_name: "Room", foreign_key: "er_id",  inverse_of: :er

  has_one :ur,  class_name: "Room", foreign_key: "dr_id",  inverse_of: :dr

  has_one :dr,  class_name: "Room", foreign_key: "ur_id",  inverse_of: :ur

  has_one :nd,  class_name: "Door", foreign_key: "sr_id",  inverse_of: :sr

  has_one :ed,  class_name: "Door", foreign_key: "wr_id",  inverse_of: :wr

  has_one :sd,  class_name: "Door", foreign_key: "nr_id",  inverse_of: :nr

  has_one :wd,  class_name: "Door", foreign_key: "er_id",  inverse_of: :er

  has_one :ud,  class_name: "Door", foreign_key: "dr_id",  inverse_of: :dr

  has_one :dd,  class_name: "Door", foreign_key: "ur_id",  inverse_of: :ur

  has_many :characters

  has_many :furnitures

  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  validates_inclusion_of :always_lit, :enclosed, :arena, in: [true, false]

  validates :roughness_multiplier, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  def anchor(destroying)
    update_attributes(nr: Room.find(nr_id)) unless nr_id.nil? || destroying
    update_attributes(er: Room.find(er_id)) unless er_id.nil? || destroying
    update_attributes(sr: Room.find(sr_id)) unless sr_id.nil? || destroying
    update_attributes(wr: Room.find(wr_id)) unless wr_id.nil? || destroying
    update_attributes(ur: Room.find(ur_id)) unless ur_id.nil? || destroying
    update_attributes(dr: Room.find(dr_id)) unless dr_id.nil? || destroying

    r = Room.find_by_nr_id(id)
    r.update_attributes(nr_id: nil) if r.present? && (sr_id.nil? || destroying)

    r = Room.find_by_er_id(id)
    r.update_attributes(er_id: nil) if r.present? && (wr_id.nil? || destroying)

    r = Room.find_by_sr_id(id)
    r.update_attributes(sr_id: nil) if r.present? && (nr_id.nil? || destroying)

    r = Room.find_by_wr_id(id)
    r.update_attributes(wr_id: nil) if r.present? && (er_id.nil? || destroying)

    r = Room.find_by_ur_id(id)
    r.update_attributes(ur_id: nil) if r.present? && (dr_id.nil? || destroying)

    r = Room.find_by_dr_id(id)
    r.update_attributes(dr_id: nil) if r.present? && (ur_id.nil? || destroying)
  end

  private

  def check_no_characters
    return if characters.count.zero?

    errors.add(:base, "Characters are still present in the room.")
  end

  def check_no_items
    return if inventory.items.count.zero?

    errors.add(:base, "Items are still present in the room.")
  end

  def check_no_furniture
    return if furnitures.count.zero?

    errors.add(:base, "Furniture is still present in the room.")
  end

  def abort_if_necessary
    throw :abort if errors[:base].length.positive?
  end

  def set_default_associations
    self.inventory = Inventory.new
  end
end
