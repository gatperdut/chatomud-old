class BoardTemplate < ApplicationRecord
  belongs_to :item_template

  validates :item_template, presence: true
end
