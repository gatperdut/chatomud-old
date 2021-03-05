class Furniture < ApplicationRecord
  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  belongs_to :room

  belongs_to :furniture_template

  serialize :kwords

  validates :short_desc, :long_desc, :full_desc, :max_seats, presence: true

  validates :max_seats, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_associated :inventory
end
