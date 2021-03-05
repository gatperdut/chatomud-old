require "mixins/grips/definition"
require "mixins/weapons/definition"

class WeaponStatTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Grips::Definition
  extend ChatoMud::Mixins::Weapons::Definition

  has_one :melee_stat_template, dependent: :destroy

  has_one :ranged_stat_template, dependent: :destroy

  belongs_to :item_template

  enum grip: all_grips

  enum base: all_weapon_bases

  validates :item_template, :grip, :base, presence: true

  validate :melee_stat_template_xor_ranged_stat_template_must_be_present

  accepts_nested_attributes_for :melee_stat_template

  accepts_nested_attributes_for :ranged_stat_template

  validates_associated :melee_stat_template, :ranged_stat_template

  private

  def melee_stat_template_xor_ranged_stat_template_must_be_present
    if melee_stat_template && ranged_stat_template
      errors.add(:melee_stat_template, "cannot be a ranged weapon too")
      errors.add(:ranged_stat_template, "cannot be a melee weapon too")
    end

    return if melee_stat_template || ranged_stat_template

    errors.add(:melee_stat_template, "either this or ranged_stat_template must be set")
    errors.add(:ranged_stat_template, "either this or melee_stat_template must be set")
  end
end
