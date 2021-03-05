class Announcement < ApplicationRecord
  validates :title, :content, presence: true
end
