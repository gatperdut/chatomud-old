class CharacterApplication < ApplicationRecord
  has_one :physical_attr_template, as: :parent, dependent: :destroy, inverse_of: :parent
end
