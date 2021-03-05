require "mixins/crafts/ingredients/definition"

class CraftIngredient < ApplicationRecord
  extend ChatoMud::Mixins::Crafts::Ingredients::Definition

  belongs_to :craft

  enum location: all_craft_ingredient_locations

  enum usage_type: all_craft_ingredient_usage_types

  serialize :item_template_codes

  validates :item_template_codes, length: { minimum: 1 }

  validates :item_template_codes, :location, :usage_type, presence: true

  validate :codes_must_point_to_item_templates

  private

  def codes_must_point_to_item_templates
    item_template_codes.each do |itc|
      errors.add(:item_template_codes, "contains non-existing item template code '#{itc}'") unless ItemTemplate.find_by_code(itc).present?
    end
  end
end
