require "mixins/characters/physical_attrs/genders/definition"
require "mixins/characters/physical_attrs/races/definition"
require "mixins/characters/physical_attrs/height/definition"
require "mixins/characters/physical_attrs/weight/definition"

class PhysicalAttrTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Genders::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Races::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Height::Definition
  extend ChatoMud::Mixins::Characters::PhysicalAttrs::Weight::Definition

  belongs_to :parent, polymorphic: true

  serialize :genders

  enum race: all_races

  enum height_category: all_height_categories

  enum weight_category: all_weight_categories

  validates :race, :height_category, :weight_category, presence: true

  validates_each :genders, allow_blank: false do |record, attr, values|
    values.each do |value|
      unless all_genders.include?(value.to_sym)
        record.errors.add(attr, "includes the invalid gender '#{value}'")
      end
    end
  end

  validate :genders_length_is_one_for_character_applications

  private

  def genders_length_is_one_for_character_applications
    return unless parent.is_a?(CharacterApplication)

    errors.add(:genders, "must contain a single gender for character applications") unless genders.count == 1
  end
end
