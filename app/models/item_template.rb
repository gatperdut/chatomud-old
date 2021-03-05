require "mixins/slots/definition"
require "securerandom"

class ItemTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Slots::Definition

  before_destroy :check_no_associated_items

  before_destroy :abort_if_necessary

  before_validation :set_code, on: :create

  has_one :horn_property_template, dependent: :destroy

  has_one :writing_implement_template, dependent: :destroy

  has_one :ink_source_template, dependent: :destroy

  has_one :spawning_ink_source_template, class_name: "InkSourceTemplate", foreign_key: "spawned_item_template_id"

  has_one :weapon_stat_template, dependent: :destroy

  has_one :missile_stat_template, dependent: :destroy

  has_one :armor_stat_template, dependent: :destroy

  has_one :shield_stat_template, dependent: :destroy

  has_one :light_source_template, dependent: :destroy

  has_one :book_template, dependent: :destroy

  has_one :board_template, dependent: :destroy

  has_one :stack, class_name: "AmountTemplate", foreign_key: "stackable_id", dependent: :destroy

  has_one :food,  class_name: "AmountTemplate", foreign_key: "edible_id",    dependent: :destroy

  has_one :fluid, class_name: "AmountTemplate", foreign_key: "fillable_id",  dependent: :destroy

  has_one :inventory_template, as: :parent, dependent: :destroy, inverse_of: :parent

  has_many :items, dependent: :destroy

  has_and_belongs_to_many :solid_fuel_consumer_templates, class_name: "SolidFuelReqTemplate"

  has_and_belongs_to_many :solid_fueler_consumers, class_name: "SolidFuelReq"

  serialize :kwords

  serialize :possible_slots

  validates :short_desc, :long_desc, :full_desc, :kwords, :code, :weight, presence: true

  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :code, uniqueness: true

  validates_inclusion_of :is_sheath, :is_quiver, in: [true, false]

  validates_each :possible_slots, allow_blank: true do |record, attr, values|
    values.each do |value|
      unless all_slots.include?(value.to_sym)
        record.errors.add(attr, "includes the invalid slot '#{value}'")
      end
    end
  end

  validates_associated :stack, :food, :fluid, :inventory_template, :weapon_stat_template, :missile_stat_template, :armor_stat_template, :shield_stat_template, :horn_property_template, :ink_source_template, :writing_implement_template, :light_source_template, :items

  validate :sheaths_and_quivers_must_have_an_inventory

  validate :fluid_cant_be_neither_food_nor_stack

  validate :food_is_always_stack

  validate :missiles_are_always_stack

  validate :missiles_cannot_be_weapons

  validate :sheaths_cannot_be_quivers_and_viceversa

  validate :food_and_fluid_must_have_amount_data_template

  validate :stack_cannot_have_amount_data_template

  validate :fluid_set_for_fluid_amount_data_template

  validate :calories_and_hydration_nil_for_fluid_amount_data_template

  validate :fluid_nil_for_food_amount_data_template

  validate :calories_and_hydration_set_for_food_amount_data_template

  accepts_nested_attributes_for :inventory_template

  accepts_nested_attributes_for :armor_stat_template

  accepts_nested_attributes_for :shield_stat_template

  accepts_nested_attributes_for :light_source_template

  accepts_nested_attributes_for :weapon_stat_template

  accepts_nested_attributes_for :stack

  accepts_nested_attributes_for :food

  accepts_nested_attributes_for :fluid

  def is_horn_template?
    horn_property_template.present?
  end

  def is_ink_source_template?
    ink_source_template.present?
  end

  def is_writing_implement_template?
    writing_implement_template.present?
  end

  def is_melee_weapon_template?
    weapon_stat_template.present? && weapon_stat_template.melee_stat_template.present?
  end

  def is_ranged_weapon_template?
    weapon_stat_template.present? && weapon_stat_template.ranged_stat_template.present?
  end

  private

  def fluid_cant_be_neither_food_nor_stack
    errors.add(:fluid, "can be neither food nor stack") if fluid && (food || stack)
  end

  def food_is_always_stack
    errors.add(:food, "must always be stack") if food && !stack
  end

  def missiles_are_always_stack
    errors.add(:missile_stat_template, "must always be stack") if food && !stack
  end

  def missiles_cannot_be_weapons
    return unless missile_stat_template && weapon_stat_template

    errors.add(:missile_stat_template, "missiles cannot be weapons")
    errors.add(:weapon_stat_template,  "weapons cannot be missiles")
  end

  def sheaths_cannot_be_quivers_and_viceversa
    return unless is_quiver && is_sheath

    errors.add(:is_quiver, "sheaths cannot be quivers")
    errors.add(:is_sheath, "quivers cannot be sheaths")
  end

  def sheaths_and_quivers_must_have_an_inventory
    errors.add(:inventory_template, "is required for sheath templates") if is_sheath && !inventory_template
    errors.add(:inventory_template, "is required for quiver templates") if is_quiver && !inventory_template
  end

  def food_and_fluid_must_have_amount_data_template
    [:food, :fluid].each do |amount|
      errors.add(amount, "must have amount_data_template") if send(amount) && send(amount).amount_data_template.nil?
    end
  end

  def stack_cannot_have_amount_data_template
    errors.add(:stack, "cannot have amount_data_template") if stack&.amount_data_template
  end

  def fluid_set_for_fluid_amount_data_template
    return unless fluid

    errors.add(:fluid, "amount_data_template:fluid must be set if amount_data_template is inside fluid") if fluid.amount_data_template.fluid.nil?
  end

  def calories_and_hydration_nil_for_fluid_amount_data_template
    return unless fluid

    errors.add(:fluid, "amount_data_template:calories must be nil if amount_data_template is inside fluid") unless fluid.amount_data_template.calories.nil?

    errors.add(:fluid, "amount_data_template:hydration must be nil if amount_data_template is inside fluid") unless fluid.amount_data_template.hydration.nil?
  end

  def fluid_nil_for_food_amount_data_template
    return unless food

    errors.add(:food, "amount_data_template:fluid must be nil if amount_data_template is inside food") unless food.amount_data_template.fluid.nil?
  end

  def calories_and_hydration_set_for_food_amount_data_template
    return unless food

    errors.add(:food, "amount_data_template:calories must be set if amount_data_template is inside food") if food.amount_data_template.calories.nil?

    errors.add(:food, "amount_data_template:hydration must be set if amount_data_template is inside food") if food.amount_data_template.hydration.nil?
  end

  def set_code
    self.code = SecureRandom.hex if code.nil?
  end

  def check_no_associated_items
    errors.add(:base, "there exist yet items associated to this item template") unless items.length.zero?
  end

  def abort_if_necessary
    throw :abort if errors[:base].length.positive?
  end
end
