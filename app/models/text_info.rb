require "mixins/languages/definition"
require "mixins/scripts/definition"
require "mixins/ink_types/definition"
require "mixins/ink_types/utils"

class TextInfo < ApplicationRecord
  extend ChatoMud::Mixins::Languages::Definition
  extend ChatoMud::Mixins::Scripts::Definition
  extend ChatoMud::Mixins::InkTypes::Definition
  include ChatoMud::Mixins::InkTypes::Utils

  belongs_to :parent, polymorphic: true

  belongs_to :character

  enum language: all_languages

  enum script: all_scripts

  enum ink_type: all_ink_types

  validates :character, presence: true

  validates :language_skill_mod, :script_skill_mod, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 100, allow_nil: true }

  validate :language_and_script_and_modifiers_set_unless_item_is_board

  validate :language_and_script_modifiers_not_set_if_item_is_board

  validate :ink_type_must_be_dipping_if_item_is_non_wipeable_writing

  private

  def language_and_script_and_modifiers_set_unless_item_is_board
    return if parent.parent.is_a?(Board)

    errors.add(:language,           "must be set if item is not Board") unless language.present?
    errors.add(:script,             "must be set if item is not Board") unless script.present?
    errors.add(:language_skill_mod, "must be set if item is not Board") unless language_skill_mod.present?
    errors.add(:script_skill_mod,   "must be set if item is not Board") unless script_skill_mod.present?
  end

  def language_and_script_modifiers_not_set_if_item_is_board
    return unless parent.parent.is_a?(Board)

    errors.add(:language_skill_mod,  "must not be set if item is Board") if language_skill_mod.present?
    errors.add(:script_skill_mod,    "must not be set if item is Board") if script_skill_mod.present?
  end

  def ink_type_must_be_dipping_if_item_is_non_wipeable_writing
    return unless parent.parent.is_a?(Writing)

    return if parent.parent.wipeable

    errors.add(:ink_type, "must be of dipping type if item is Writing and non-wipeable") unless is_dipping_ink_type?(ink_type)
  end
end
