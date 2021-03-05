class CharacterTemplate < ApplicationRecord
  has_one :health_template, dependent: :destroy

  has_one :physical_attr_template, as: :parent, dependent: :destroy, inverse_of: :parent

  has_one :attribute_set_template, dependent: :destroy

  has_one :skill_set_template, dependent: :destroy

  has_one :inventory_template, as: :parent, dependent: :destroy, inverse_of: :parent

  has_one :aasm_template, dependent: :destroy

  has_one :choice_template, dependent: :destroy

  serialize :names

  serialize :short_descs

  serialize :long_desc_endings

  validates :short_desc, :long_desc, :full_desc, :code, :names, :short_descs, :long_desc_endings, :noun, :physical_attr_template, :health_template, :attribute_set_template, :skill_set_template, :aasm_template, :choice_template, presence: true

  validates :code, uniqueness: true

  validates_associated :health_template, :attribute_set_template, :skill_set_template, :inventory_template, :aasm_template, :choice_template, :physical_attr_template
end
