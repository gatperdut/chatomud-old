require "mixins/slots/definition"

class CharacterOutfitter < ApplicationRecord
  extend ChatoMud::Mixins::Slots::Definition

  validate :codes_must_point_to_item_templates

  validates :code, presence: true, uniqueness: true

  serialize :item_template_codes

  private

  def valid_content?(element)
    case element
      when Hash
        element.each_key do |key|
          return false if !self.class.all_slots.include?(key) && !valid_content?(key)

          return false unless valid_content?(element[key])
        end
        true
      when Array
        element.each do |code|
          return false unless valid_content?(code)
        end
        true
      when Symbol
        ItemTemplate.find_by_code(element.to_s)
    end
  end

  def codes_must_point_to_item_templates
    item_template_codes.each_key do |wloc|
      errors.add(:item_template_codes, "contains the invalid code '#{item_template_codes[wloc]}'") unless valid_content?(item_template_codes[wloc])
    end
  end
end
