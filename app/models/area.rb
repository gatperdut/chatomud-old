class Area < ApplicationRecord
  has_many :rooms, dependent: :destroy

  belongs_to :superarea

  validates :name, presence: true

  validate :at_least_one_room, on: :create

  accepts_nested_attributes_for :rooms, reject_if: :persisted?

  private

  def at_least_one_room
    errors.add(:base, "when creating an area at least one room must be provided") if rooms.empty?
  end
end
