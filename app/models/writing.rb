class Writing < ApplicationRecord
  belongs_to :item

  has_one :post, as: :parent, dependent: :destroy, inverse_of: :parent

  validates :post, presence: true

  validates_associated :post

  validates_inclusion_of :wipeable, in: [true, false]
end
