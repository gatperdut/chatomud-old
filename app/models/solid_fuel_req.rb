class SolidFuelReq < ApplicationRecord
  belongs_to :light_source

  has_and_belongs_to_many :options, class_name: "ItemTemplate"

  # TODO: validate valid fuels does not include the light source itself

  validates :options, length: { minimum: 1 }
end
