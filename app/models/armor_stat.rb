require "mixins/body_parts/definition"
require "mixins/armor/definition"

class ArmorStat < ApplicationRecord
  extend ChatoMud::Mixins::BodyParts::Definition
  extend ChatoMud::Mixins::Armor::Definition

  belongs_to :item

  enum maneuver_impediment: all_maneuver_impediments

  enum ranged_attack_impediment: all_ranged_attack_impediments

  serialize :body_parts

  validates :item, :protection_level, :penalty_level, :roll_mod, :critical_mod, :body_parts, :maneuver_impediment, :ranged_attack_impediment, presence: true

  validates :body_parts, length: { minimum: 1 }

  validates_each :body_parts, allow_blank: true do |record, attr, values|
    values.each do |value|
      unless all_body_parts.include?(value.to_sym)
        record.errors.add(attr, "includes the invalid body part '#{value}'")
      end
    end
  end
end
