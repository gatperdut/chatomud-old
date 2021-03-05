require "mixins/weapons/definition"
require "mixins/damage/definition"

class Attack < ApplicationRecord
  extend ChatoMud::Mixins::Weapons::Definition
  extend ChatoMud::Mixins::Damage::Definition

  enum base: all_weapon_bases

  enum critical_severity: all_critical_severities + [:no_critical]

  enum critical_type: all_critical_types + [:not_applicable]

  validates :score_limit, :base, :against, :hits, :critical_severity, :critical_type, presence: true

  validates_inclusion_of :connects, in: [true, false]

  validates :score_limit, numericality: { only_integer: true, less_than_or_equal_to: 150, greater_than_or_equal_to: 1 }

  validate :critical_type_present_if_critical_severity_present

  def is_critical?
    !no_critical?
  end

  def description
    return "" unless connects

    text = "#{hits} hits."

    if is_critical?
      text << " Critical severity: #{critical_severity}, type: #{critical_type}."
    else
      text << " Not a critical."
    end

    text
  end

  private

  def critical_type_present_if_critical_severity_present
    return unless critical_severity != :no_critical && critical_type == :not_applicable

    errors.add(:critical_type, "must be assigned when a critical severity is given")
  end
end
