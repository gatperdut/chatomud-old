class LightSourceTemplate < ApplicationRecord
  belongs_to :item_template

  has_one :capacity, class_name: "AmountTemplate", foreign_key: "fuelable_id", dependent: :destroy

  has_one :liquid_fuel_req_template, dependent: :destroy

  has_one :solid_fuel_req_template, dependent: :destroy

  accepts_nested_attributes_for :liquid_fuel_req_template

  accepts_nested_attributes_for :solid_fuel_req_template

  validates_associated :liquid_fuel_req_template, :solid_fuel_req_template, :capacity

  validates :item_template, presence: true

  validates :efficiency, :burndown, presence: true

  validates :capacity, presence: true, if: :requires_fuel?

  validates_inclusion_of :lit, in: [true, false]

  validates_inclusion_of :must_be_held_to_light, in: [true, false]

  validates :efficiency, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :burndown,   numericality: { only_integer: true, greater_than_or_equal_to: 1, lower_than_or_equal_to: :efficiency }

  validate :liquid_xor_solid_fuel_req_template

  validate :must_be_lit_if_eternal

  private

  def requires_fuel?
    !!liquid_fuel_req_template || !!solid_fuel_req_template
  end

  def is_eternal?
    !capacity && !requires_fuel?
  end

  def liquid_xor_solid_fuel_req_template
    return unless liquid_fuel_req_template && solid_fuel_req_template

    errors.add(:liquid_fuel_req_template, " cannot use solid fuel template too")
    errors.add(:solid_fuel_req_template, " cannot use liquid fuel template too")
  end

  def must_be_lit_if_eternal
    errors.add(:lit, " must be true if the light is eternal") if !lit && is_eternal?
  end
end
