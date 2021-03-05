class Board < ApplicationRecord
  belongs_to :item

  has_many :posts, as: :parent, dependent: :destroy, inverse_of: :parent

  validates :item, presence: true

  validates_associated :posts
end
