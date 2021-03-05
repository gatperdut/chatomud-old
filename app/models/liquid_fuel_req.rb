require "mixins/fluids/definition"

class LiquidFuelReq < ApplicationRecord
  extend ChatoMud::Mixins::Fluids::Definition

  belongs_to :light_source

  serialize :options

  validates :options, length: { minimum: 1 }

  validates_each :options, allow_blank: true do |record, attr, values|
    values.each do |value|
      unless all_fluids.include?(value.to_sym)
        record.errors.add(attr, "includes the invalid fluids '#{value}'")
      end
    end
  end
end
