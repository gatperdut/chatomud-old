class Health < ApplicationRecord
  belongs_to :character

  has_many :wounds, dependent: :destroy

  validates :character, :exhaustion, presence: true

  validates :exhaustion, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :exhaustion_lower_than_or_equal_to_constitution_value

  private

  def exhaustion_lower_than_or_equal_to_constitution_value
    errors.add(:exhaustion, "must be lower than or equal to the constitution value") if exhaustion > character.attribute_set.con
  end
end
