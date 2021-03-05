class Nourishment < ApplicationRecord
  belongs_to :character, optional: true

  validates :calories, :hydration, presence: true

  validates :calories, :hydration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
