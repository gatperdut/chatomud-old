require "mixins/slots/definition"

class Item < ApplicationRecord
  include ChatoMud::Mixins::Slots::Definition

  extend ChatoMud::Mixins::Slots::Definition

  has_one :stack, class_name: "Amount", foreign_key: "stackable_id", dependent: :destroy

  has_one :food,  class_name: "Amount", foreign_key: "edible_id",    dependent: :destroy

  has_one :fluid, class_name: "Amount", foreign_key: "fillable_id",  dependent: :destroy

  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  has_one :light_source, dependent: :destroy

  has_one :horn_property, dependent: :destroy

  has_one :ink_source, dependent: :destroy

  has_one :writing_implement, dependent: :destroy

  has_one :book, dependent: :destroy

  has_one :board, dependent: :destroy

  has_one :weapon_stat, dependent: :destroy

  has_one :missile_stat, dependent: :destroy

  has_one :armor_stat, dependent: :destroy

  has_one :shield_stat, dependent: :destroy

  belongs_to :containing_inventory, class_name: "Inventory"

  belongs_to :item_template

  has_one :writing, dependent: :destroy

  has_and_belongs_to_many :lockables, class_name: "Lock"

  serialize :possible_slots

  serialize :kwords

  enum slot: all_slots

  accepts_nested_attributes_for :inventory

  accepts_nested_attributes_for :fluid

  accepts_nested_attributes_for :stack

  accepts_nested_attributes_for :food

  accepts_nested_attributes_for :armor_stat

  accepts_nested_attributes_for :weapon_stat

  validates :short_desc, :long_desc, :full_desc, :slot, :item_template, :weight, presence: true

  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_inclusion_of :is_sheath, :is_quiver, in: [true, false]

  validates_each :possible_slots, allow_blank: true do |record, attr, values|
    values.each do |value|
      unless all_slots.include?(value.to_sym)
        record.errors.add(attr, "includes the invalid slot '#{value}'")
      end
    end
  end

  validates_associated :stack, :food, :fluid, :inventory, :weapon_stat, :missile_stat, :armor_stat, :shield_stat, :horn_property, :ink_source, :writing_implement, :light_source, :book, :board, :writing

  validate :fluid_cant_be_neither_food_nor_stack

  validate :weapons_have_valid_grip_slot

  validate :sheaths_hold_only_one_sheathable_weapon

  validate :weapons_sheaths_and_quivers_cannot_be_stack

  validate :sheaths_cannot_be_quivers_and_viceversa

  validate :sheaths_and_quivers_must_have_an_inventory

  validate :missiles_cannot_be_weapons

  validate :missiles_are_always_stack

  validate :slot_is_valid

  validate :possible_slots_must_not_include_void_and_hands

  validate :food_and_fluid_must_have_amount_data

  validate :stack_cannot_have_amount_data

  validate :fluid_set_for_fluid_amount_data

  validate :calories_and_hydration_nil_for_fluid_amount_data

  validate :fluid_nil_for_food_amount_data

  validate :calories_and_hydration_set_for_food_amount_data

  def is_weapon?
    weapon_stat.present?
  end

  def is_horn?
    horn_property.present?
  end

  def is_ink_source?
    ink_source.present?
  end

  def is_writing_implement?
    writing_implement.present?
  end

  def is_light_source?
    light_source.present?
  end

  def is_melee_weapon?
    is_weapon? && weapon_stat.melee_stat.present?
  end

  def is_ranged_weapon?
    is_weapon? && weapon_stat.ranged_stat.present?
  end

  def is_missile?
    missile_stat.present?
  end

  def is_wielded_two_hands?
    slot.to_sym == :w2hands
  end

  def is_wielded_one_handed?
    slot.to_sym == :wrhand || slot.to_sym == :wlhand
  end

  private

  def void_plus_hand_slots
    [:void] + hand_slots
  end

  def possible_slots_plus_void_plus_hands
    (possible_slots + void_plus_hand_slots).map(&:to_sym)
  end

  def slot_is_valid
    errors.add(:slot, "not valid for this item") unless possible_slots_plus_void_plus_hands.include?(slot.to_sym)
  end

  def possible_slots_must_not_include_void_and_hands
    errors.add(:possible_slots, "void and hand slots are not allowed") if (void_plus_hand_slots & possible_slots).any?
  end

  def weapons_have_valid_grip_slot
    return unless is_weapon?

    errors.add(:slot, "can only be wielded with one hand") if is_wielded_two_hands? && weapon_stat.one_handed?
    errors.add(:slot, "can only be wielded with two hands") if is_wielded_one_handed? && weapon_stat.two_handed?
  end

  def weapons_sheaths_and_quivers_cannot_be_stack
    errors.add(:weapon_stat, "cannot be stack") if weapon_stat && stack
    errors.add(:is_sheath, "cannot be stack") if is_sheath && stack
    errors.add(:is_quiver, "cannot be stack") if is_quiver && stack
  end

  def fluid_cant_be_neither_food_nor_stack
    errors.add(:fluid, "can be neither food nor stack") if fluid && (food || stack)
  end

  def missiles_are_always_stack
    errors.add(:missile_stat, "must always be stack") if missile_stat && !stack
  end

  def missiles_cannot_be_weapons
    return unless missile_stat && weapon_stat

    errors.add(:missile_stat, "missiles cannot be weapons")
    errors.add(:weapon_stat, "weapons cannot be missiles")
  end

  def sheaths_cannot_be_quivers_and_viceversa
    return unless is_sheath && is_quiver

    errors.add(:is_quiver, "sheaths cannot be quivers")
    errors.add(:is_sheath, "quivers cannot be sheaths")
  end

  def sheaths_and_quivers_must_have_an_inventory
    errors.add(:inventory, "is required for sheaths") if is_sheath && !inventory
    errors.add(:inventory, "is required for quivers") if is_quiver && !inventory
  end

  def sheaths_hold_only_one_sheathable_weapon
    return unless is_sheath

    items = inventory.items

    errors.add(:inventory, "sheath inventories can hold only one item") if items.length > 1

    item = items[0]

    errors.add(:inventory, "sheath inventories can only hold sheathable weapons") if item&.is_melee_weapon?
  end

  def food_and_fluid_must_have_amount_data
    [:food, :fluid].each do |amount|
      errors.add(amount, "must have amount_data") if send(amount) && send(amount).amount_data.nil?
    end
  end

  def stack_cannot_have_amount_data
    errors.add(:stack, "cannot have amount_data") if stack&.amount_data
  end

  def fluid_set_for_fluid_amount_data
    return unless fluid

    errors.add(:fluid, "amount_data:fluid must be set if amount_data is inside fluid") if fluid.amount_data.fluid.nil?
  end

  def calories_and_hydration_nil_for_fluid_amount_data
    return unless fluid

    errors.add(:fluid, "amount_data:calories must be nil if amount_data is inside fluid") unless fluid.amount_data.calories.nil?

    errors.add(:fluid, "amount_data:hydration must be nil if amount_data is inside fluid") unless fluid.amount_data.hydration.nil?
  end

  def fluid_nil_for_food_amount_data
    return unless food

    errors.add(:food, "amount_data:fluid must be nil if amount_data is inside food") unless food.amount_data.fluid.nil?
  end

  def calories_and_hydration_set_for_food_amount_data
    return unless food

    errors.add(:food, "amount_data:calories must be set if amount_data is inside food") if food.amount_data.calories.nil?

    errors.add(:food, "amount_data:hydration must be set if amount_data is inside food") if food.amount_data.hydration.nil?
  end
end
