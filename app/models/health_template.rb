class HealthTemplate < ApplicationRecord
  belongs_to :character_template

  validates :character_template, presence: true
end
