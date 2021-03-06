class Amount < ApplicationRecord
  has_one :amount_data, dependent: :destroy

  belongs_to :stackable,   class_name: "Item",        dependent: :destroy, optional: true

  belongs_to :edible,      class_name: "Item",        dependent: :destroy, optional: true

  belongs_to :fillable,    class_name: "Item",        dependent: :destroy, optional: true

  belongs_to :fuelable,    class_name: "LightSource", dependent: :destroy, optional: true

  validates :current, :max, numericality: { only_integer: true }

  validates :current, numericality: { less_than_or_equal_to: :max, greater_than_or_equal_to: 0 }

  validates :max, numericality: { greater_than_or_equal_to: 1 }

  validates_associated :amount_data
end
