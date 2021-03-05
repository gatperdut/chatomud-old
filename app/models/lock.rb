class Lock < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_and_belongs_to_many :lockers, class_name: "Item"

  validates :parent, presence: true

  validates_inclusion_of :locked, in: [true, false]

  validate :can_be_locked_only_when_parent_is_closed

  private

  def can_be_locked_only_when_parent_is_closed
    errors.add(:parent, "cannot be open when locking") if locked && parent.open
  end
end
