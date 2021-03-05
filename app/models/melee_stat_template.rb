class MeleeStatTemplate < ApplicationRecord
  belongs_to :weapon_stat_template

  validates :weapon_stat_template, :sheathed_desc, presence: true
end
