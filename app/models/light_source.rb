class LightSource < ApplicationRecord
  belongs_to :item

  has_one :capacity, class_name: "Amount", foreign_key: "fuelable_id", dependent: :destroy

  has_one :liquid_fuel_req, dependent: :destroy

  has_one :solid_fuel_req, dependent: :destroy

  accepts_nested_attributes_for :liquid_fuel_req

  accepts_nested_attributes_for :solid_fuel_req

  validates_associated :liquid_fuel_req, :solid_fuel_req, :capacity

  validates :efficiency, :burndown, :item, presence: true

  validates :efficiency, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :burndown,   numericality: { only_integer: true, greater_than_or_equal_to: 0, lower_than_or_equal_to: :efficiency }

  validates :capacity, presence: true, if: :requires_fuel?

  validates_inclusion_of :lit, in: [true, false]

  validates_inclusion_of :must_be_held_to_light, in: [true, false]

  validate :liquid_xor_solid_fuel_req

  validate :must_be_lit_if_eternal

  private

  def requires_fuel?
    !!liquid_fuel_req || !!solid_fuel_req
  end

  def is_eternal?
    !capacity && !requires_fuel?
  end

  def liquid_xor_solid_fuel_req
    return unless liquid_fuel_req && solid_fuel_req

    errors.add(:liquid_fuel_req, " cannot use solid fuel too")
    errors.add(:solid_fuel_req, " cannot use liquid fuel too")
  end

  def must_be_lit_if_eternal
    errors.add(:lit, " must be true if the light is eternal") if !lit && is_eternal?
  end
end
