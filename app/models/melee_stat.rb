class MeleeStat < ApplicationRecord
  belongs_to :weapon_stat

  validates :weapon_stat, :sheathed_desc, presence: true
end
