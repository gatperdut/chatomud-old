require "mixins/missile/definition"
require "mixins/ranges/definition"

class RangedStatTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Missile::Definition

  extend ChatoMud::Mixins::Ranges::Definition

  has_one :inventory_template, as: :parent, dependent: :destroy, inverse_of: :parent

  belongs_to :weapon_stat_template

  enum missile_type: all_missile_types

  serialize :ranges_suitability

  validates :inventory_template, :missile_type, presence: true

  validates_inclusion_of :can_remain_loaded, in: [true, false]

  validates :ranges_suitability, length: { minimum: 4, maximum: 4 }

  validate :each_range_present_once

  accepts_nested_attributes_for :inventory_template

  private

  def each_range_present_once
    self.class.all_ranges.each do |range|
      errors.add(:ranges_suitability, "#{range} is not present") unless ranges_suitability.map(&:to_sym).include?(range.to_sym)
    end
  end
end
