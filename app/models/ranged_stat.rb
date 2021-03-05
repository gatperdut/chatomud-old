require "mixins/missile/definition"
require "mixins/ranges/definition"

class RangedStat < ApplicationRecord
  extend ChatoMud::Mixins::Missile::Definition

  extend ChatoMud::Mixins::Ranges::Definition

  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  belongs_to :weapon_stat

  enum missile_type: all_missile_types

  serialize :ranges_suitability

  validates :inventory, :missile_type, presence: true

  validates_inclusion_of :can_remain_loaded, in: [true, false]

  validates :ranges_suitability, length: { minimum: 4, maximum: 4 }

  validate :holds_only_one_valid_missile

  validate :each_range_present_once

  accepts_nested_attributes_for :inventory

  private

  def holds_only_one_valid_missile
    items = inventory.items

    errors.add(:inventory, "ranged weapons can hold only one item") if items.length > 1

    item = items[0]

    return unless item

    if item.is_missile?
      errors.add(:inventory, "the missile stowed must be of type #{missile_type}") unless item.missile_stat.missile_type == missile_type
    else
      errors.add(:inventory, "ranged weapons can only hold one missile item")
    end
  end

  def each_range_present_once
    self.class.all_ranges.each do |range|
      errors.add(:ranges_suitability, "#{range} is not present") unless ranges_suitability.map(&:to_sym).include?(range.to_sym)
    end
  end
end
