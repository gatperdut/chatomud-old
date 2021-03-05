class CraftStep < ApplicationRecord
  has_one :craft_test, dependent: :destroy

  has_many :craft_item_results, dependent: :destroy

  belongs_to :craft

  validates :echo_first, :echo_third, :delay, presence: true

  validates :delay, numericality: { only_integer: true, greater_than_or_equal_to: 5 }

  validates :fail_first, :fail_third, presence: true, if: proc { |cs| cs.craft_test.present? }

  validate :fail_first_present_only_with_test

  validate :ingredient_indexes_must_be_same_in_all_echoes

  validate :fail_echoes_contain_no_ingredient_references

  accepts_nested_attributes_for :craft_test

  accepts_nested_attributes_for :craft_item_results, allow_destroy: true

  def find_occurrence_indexes(echo)
    echo_string = send(echo)

    return [] unless echo_string.present?

    occurrences = echo_string.scan(/\$[0-9]+/)

    occurrences.map { |b| b[1..] }.map(&:to_i)
  end

  private

  def fail_first_present_only_with_test
    test_present = craft_test.present?

    errors.add(:fail_first, "must be present if there is a test")      if !fail_first.present? &&  test_present
    errors.add(:fail_first, "must not be present if there is no test") if  fail_first.present? && !test_present

    errors.add(:fail_third, "must be present if there is a test")      if !fail_third.present? &&  test_present
    errors.add(:fail_third, "must not be present if there is no test") if  fail_third.present? && !test_present
  end

  def ingredient_indexes_must_be_same_in_all_echoes
    indexes = []

    [:echo_first, :echo_third].each do |echo|
      occurrence_indexes = find_occurrence_indexes(echo)

      occurrence_indexes.each do |occurrence_index|
        if occurrence_index < 1
          errors.add(:base, "ingredient indexes must be >= 1 (found #{occurrence_index})")
          next
        end
        indexes[occurrence_index - 1] = 0 unless indexes[occurrence_index - 1].present?
        indexes[occurrence_index - 1] += 1
      end
    end

    errors.add(:base, "indexes used must be homogeneous across all echoes") unless indexes.compact.uniq.length <= 1
  end

  def fail_echoes_contain_no_ingredient_references
    [:fail_first, :fail_third].each do |echo|
      occurrence_indexes = find_occurrence_indexes(echo)

      errors.add(echo, "may not contain ingredient references") unless occurrence_indexes.length.zero?
    end
  end
end
