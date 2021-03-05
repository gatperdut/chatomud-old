class Door < ApplicationRecord
  has_one :nr,  class_name: "Room", foreign_key: "sd_id"

  has_one :er,  class_name: "Room", foreign_key: "wd_id"

  has_one :sr,  class_name: "Room", foreign_key: "nd_id"

  has_one :wr,  class_name: "Room", foreign_key: "ed_id"

  has_one :ur,  class_name: "Room", foreign_key: "dd_id"

  has_one :dr,  class_name: "Room", foreign_key: "ud_id"

  has_one :lock, as: :parent, dependent: :destroy, inverse_of: :parent

  validates :short_desc, :long_desc, :full_desc, presence: true

  validates_inclusion_of :open, in: [true, false]

  validates_inclusion_of :see_through, in: [true, false]

  validate :only_one_direction_set

  validate :only_door_between_rooms, on: :create

  def anchor(destroying)
    r = Room.find_by_id(nr_id)
    r.update_attributes(sd_id: destroying ? nil : id) if r.present?
    r = Room.find_by_id(sr_id)
    r.update_attributes(nd_id: destroying ? nil : id) if r.present?

    r = Room.find_by_id(er_id)
    r.update_attributes(wd_id: destroying ? nil : id) if r.present?
    r = Room.find_by_id(wr_id)
    r.update_attributes(ed_id: destroying ? nil : id) if r.present?

    r = Room.find_by_id(ur_id)
    r.update_attributes(dd_id: destroying ? nil : id) if r.present?
    r = Room.find_by_id(dr_id)
    r.update_attributes(ud_id: destroying ? nil : id) if r.present?
  end

  private

  def only_one_direction_set
    counter = 0

    counter += 1 if nr_id.present? && sr_id.present?
    counter += 1 if er_id.present? && wr_id.present?
    counter += 1 if ur_id.present? && dr_id.present?

    errors.add(:base, "only one orientation (n-s, e-w or u-d) is allowed") unless counter == 1
  end

  def only_door_between_rooms
    counter = 0

    counter += 1 if (nr_id.present? && sr_id.present?) && (Door.find_by(nr_id: nr_id, sr_id: sr_id) || Door.find_by(nr_id: sr_id, sr_id: nr_id))
    counter += 1 if (er_id.present? && wr_id.present?) && (Door.find_by(er_id: er_id, wr_id: wr_id) || Door.find_by(er_id: wr_id, wr_id: er_id))
    counter += 1 if (ur_id.present? && dr_id.present?) && (Door.find_by(ur_id: ur_id, dr_id: dr_id) || Door.find_by(ur_id: dr_id, dr_id: ur_id))

    errors.add(:base, "there is a door already present between the two rooms") if counter.positive?
  end
end
