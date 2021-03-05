class AttributeBonus < ApplicationRecord
  validates :limit, :bonus, :label, presence: true
end
