require "mixins/characters/skill_set/definition"

class CraftItemResult < ApplicationRecord
  extend ChatoMud::Mixins::Characters::SkillSet::Definition

  belongs_to :craft_step

  enum skill: all_skills

  validates :item_template_code, :how_many, presence: true

  validates :how_many, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validate :code_must_point_to_item_template

  validate :how_many_agrees_with_stackability

  private

  def code_must_point_to_item_template
    errors.add(:item_template_code, "no item template found with code '#{item_template_code}'") unless ItemTemplate.find_by_code(item_template_code).present?
  end

  def how_many_agrees_with_stackability
    item_template = ItemTemplate.find_by_code(item_template_code)

    return unless item_template.present?

    is_stackable      = item_template.stack.present?
    must_be_stackable = how_many.present?

    errors.add(:item_template_code, "'#{item_template_code}' should be stackable") if  must_be_stackable && !is_stackable
    errors.add(:item_template_code, "'#{item_template_code}' cannot be stackable") if !must_be_stackable &&  is_stackable
  end
end
