class Superarea < ApplicationRecord
  has_many :areas, dependent: :destroy

  validates :name, presence: true

  validate :at_least_one_area, on: :create

  accepts_nested_attributes_for :areas, reject_if: :persisted?

  private

  def at_least_one_area
    errors.add(:base, "when creating a superarea at least one area must be provided") if areas.empty?
  end
end
