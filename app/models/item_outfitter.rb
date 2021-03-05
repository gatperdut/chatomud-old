class ItemOutfitter < ApplicationRecord
  validate :codes_must_point_to_item_templates

  validates :code, presence: true, uniqueness: true

  serialize :item_template_codes

  private

  def valid_content?(element)
    case element
      when Hash
        element.each_key do |key|
          return false unless valid_content?(key)
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
    item_template_codes.each do |itc|
      errors.add(:item_template_codes, "contains invalid codes") unless valid_content?(itc)
    end
  end
end
