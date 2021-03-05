class Player < ApplicationRecord
  before_create :generate_authentication_token

  has_one :setting, dependent: :destroy

  has_many :characters, dependent: :destroy

  has_secure_password

  # \A => start of the string, \z => end of the string (including \n)
  validates :username, format: { with: /\A\w+\z/ }, uniqueness: true, length: { within: 3..20 }

  validates :username, :setting, presence: true

  validate :max_one_active_character

  validates_associated :setting, :characters

  accepts_nested_attributes_for :setting

  def current_character
    characters.find_by_active(true)
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token

      self.authentication_token = token

      break if self.class.where(authentication_token: token).count.zero?
    end
  end

  def max_one_active_character
    return unless characters.select(&:active).count > 1

    errors.add(:characters, "there can be only 1 active at any given time")
  end
end
