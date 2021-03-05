class LockTemplate < ApplicationRecord
  belongs_to :parent, polymorphic: true

  validates :parent, presence: true
end
