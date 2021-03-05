class Craft < ApplicationRecord
  has_many :craft_steps, dependent: :destroy

  has_many :craft_ingredients, dependent: :destroy

  validates :category, :name, presence: true

  validates_uniqueness_of :name, scope: :category

  validates :craft_steps, length: { minimum: 1 }

  validate :each_ingredient_appears_once_and_only_once

  accepts_nested_attributes_for :craft_ingredients, allow_destroy: true

  accepts_nested_attributes_for :craft_steps, allow_destroy: true

  private

  def each_ingredient_appears_once_and_only_once
    ingredient_appearances = []
    craft_ingredients.reject(&:marked_for_destruction?).length.times do
      ingredient_appearances << 0
    end

    craft_steps.each do |craft_step|
      occurrence_indexes = craft_step.find_occurrence_indexes(:echo_first)

      occurrence_indexes.each do |occurrence_index|
        ingredient_appearances[occurrence_index - 1] += 1
      end
    end

    ingredient_appearances.each do |ingredient_appearance|
      errors.add(:craft_ingredients, "appears a total of #{ingredient_appearance} times in the echoes instead of once") unless ingredient_appearance == 1
    end
  end
end
