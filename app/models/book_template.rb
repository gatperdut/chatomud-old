class BookTemplate < ApplicationRecord
  belongs_to :item_template

  validates :item_template, presence: true

  validates :page_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
