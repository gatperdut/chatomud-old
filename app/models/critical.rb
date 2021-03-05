require "mixins/damage/definition"

class Critical < ApplicationRecord
  extend ChatoMud::Mixins::Damage::Definition

  enum damage_type: all_critical_types

  enum severity: all_critical_severities

  enum attack_stun_type: all_attack_stun_types + [:no_attack_stun_applied]

  enum parry_stun_type: all_parry_stun_types + [:no_parry_stun_applied]

  validates :score_limit, :extra_hits, :blood_loss, :attack_stun_rounds, :attack_stun_penalty, :parry_stun_rounds, :parry_stun_penalty, :message, presence: true

  validates :score_limit, numericality: { only_integer: true, less_than_or_equal_to: 100, greater_than_or_equal_to: 1 }

  validates :blood_loss, :extra_hits, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :attack_stun_is_valid

  validate :parry_stun_is_valid

  validate :no_parry_stun_is_valid, if: :no_parry?

  private

  def attack_stun_is_valid
    if no_attack_stun_applied?
      errors.add(:attack_stun_rounds,  "only usable when attack_stun_type is applicable") if attack_stun_rounds.positive?
      errors.add(:attack_stun_penalty, "only usable when attack_stun_type is :attack_penalty") if attack_stun_penalty.positive?
    elsif no_attack?
      errors.add(:attack_stun_rounds, "minimum 1 when attack_stun_type is :no_attack") if attack_stun_rounds < 1
      errors.add(:attack_stun_penalty, "not usable when attack_stun_type is :attack_penalty") if attack_stun_penalty.positive?
    elsif attack_penalty?
      errors.add(:attack_stun_rounds, "minimum 1 when attack_stun_type is :attack_penalty") if attack_stun_rounds < 1
      errors.add(:attack_stun_penalty, "minimum 1 when attack_stun_type is :attack_penalty") if attack_stun_penalty < 1
    else
      raise "unknown value for enum :attack_stun_type"
    end
  end

  def parry_stun_is_valid
    if no_parry_stun_applied?
      errors.add(:parry_stun_rounds,  "only usable when parry_stun_type is applicable") if parry_stun_rounds.positive?
      errors.add(:parry_stun_penalty, "only usable when parry_stun_type is :parry_penalty") if parry_stun_penalty.positive?
    elsif no_parry?
      errors.add(:parry_stun_rounds, "minimum 1 when parry_stun_type is :no_parry") if parry_stun_rounds < 1
      errors.add(:parry_stun_penalty, "not usable when parry_stun_type is :parry_penalty") if parry_stun_penalty.positive?
    elsif parry_penalty?
      errors.add(:parry_stun_rounds, "minimum 1 when parry_stun_type is :parry_penalty") if parry_stun_rounds < 1
      errors.add(:parry_stun_penalty, "minimum 1 when parry_stun_type is :parry_penalty") if parry_stun_penalty < 1
    else
      raise "unknown value for enum :parry_stun_type"
    end
  end
end
