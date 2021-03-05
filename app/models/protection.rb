class Protection < ApplicationRecord
  validates :level, uniqueness: true, numericality: { only_integer: true, less_than_or_equal_to: 20, greater_than_or_equal_to: 1 }

  validates :level, :min_penalty, :max_penalty, presence: true

  validates :min_penalty, :max_penalty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :min_penalty_lower_than_or_equal_to_max_penalty

  validate :penalty_range_is_lower_than_or_equal_to_50

  private

  def min_penalty_lower_than_or_equal_to_max_penalty
    errors.add(:min_penalty, "must be lower than or equal to max_penalty") if max_penalty < min_penalty
  end

  def penalty_range_is_lower_than_or_equal_to_50
    errors.add(:base, "max_penalty - min_penalty must be 50 or less") if max_penalty - min_penalty > 50
  end
end
