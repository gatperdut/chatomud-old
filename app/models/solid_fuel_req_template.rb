class SolidFuelReqTemplate < ApplicationRecord
  belongs_to :light_source_template

  has_and_belongs_to_many :options, class_name: "ItemTemplate"

  validates :options, length: { minimum: 1 }
end
