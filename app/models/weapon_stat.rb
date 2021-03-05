require "mixins/weapons/definition"
require "mixins/grips/definition"

class WeaponStat < ApplicationRecord
  extend ChatoMud::Mixins::Weapons::Definition
  extend ChatoMud::Mixins::Grips::Definition

  has_one :melee_stat, dependent: :destroy

  has_one :ranged_stat, dependent: :destroy

  belongs_to :item

  enum grip: all_grips

  enum base: all_weapon_bases

  validates :item, :grip, :base, presence: true

  validate :melee_stat_xor_ranged_stat_must_be_present

  validate :ranged_weapons_must_have_grip_both

  validates_associated :melee_stat, :ranged_stat

  accepts_nested_attributes_for :melee_stat

  accepts_nested_attributes_for :ranged_stat

  private

  def melee_stat_xor_ranged_stat_must_be_present
    if melee_stat && ranged_stat
      errors.add(:melee_stat, "cannot be a ranged weapon too")
      errors.add(:ranged_stat, "cannot be a melee weapon too")
    end

    return if melee_stat || ranged_stat

    errors.add(:melee_stat, "either this or ranged_stat must be set")
    errors.add(:ranged_stat, "either this or melee_stat must be set")
  end

  def ranged_weapons_must_have_grip_both
    errors.add(:grip, "must be :both for ranged weapons") if ranged_stat && grip.to_sym != :both
  end
end
