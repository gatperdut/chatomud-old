class FurnitureTemplate < ApplicationRecord
  has_one :inventory_template, as: :parent, dependent: :destroy, inverse_of: :parent

  has_many :furnitures, dependent: :destroy

  serialize :kwords

  validates :short_desc, :long_desc, :full_desc, :code, :max_seats, presence: true

  validates :max_seats, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :code, uniqueness: true

  validates_associated :inventory_template
end
