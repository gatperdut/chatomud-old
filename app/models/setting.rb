class Setting < ApplicationRecord
  belongs_to :player

  validates :player, presence: true

  validates_inclusion_of :ansi_coloring, in: [true, false]
end
