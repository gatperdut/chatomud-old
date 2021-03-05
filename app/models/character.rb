require "mixins/characters/gifts/definition"

class Character < ApplicationRecord
  extend ChatoMud::Mixins::Characters::Gifts::Definition

  before_validation :set_default_associations, on: :create

  scope :pcs, -> { where(npc: false) }

  scope :npcs, -> { where(npc: true) }

  scope :gladiators, -> { where(gladiator: true) }

  has_one :health, dependent: :destroy

  has_one :physical_attr, dependent: :destroy

  has_one :nourishment, dependent: :destroy

  has_one :attribute_set, dependent: :destroy

  has_one :skill_set, dependent: :destroy

  has_one :inventory, as: :parent, dependent: :destroy, inverse_of: :parent

  has_one :choice, dependent: :destroy

  has_one :aasm, dependent: :destroy

  has_many :text_infos, dependent: :restrict_with_exception

  belongs_to :player, optional: true

  belongs_to :room

  serialize :kwords

  serialize :gifts

  validates_associated :health, :attribute_set, :inventory, :skill_set, :physical_attr, :choice, :nourishment

  validates_inclusion_of :gladiator, in: [true, false]

  validates :short_desc, :long_desc, :full_desc, :inventory, :health, :attribute_set, :skill_set, :physical_attr, :choice, presence: true

  validates :aasm, presence: true, if: -> { is_npc? }

  validates :aasm, absence: true, if: -> { is_pc? }

  validates :nourishment, presence: true, if: -> { is_pc? }

  validates :nourishment, absence: true, if: -> { is_npc? }

  validates_inclusion_of :npc, :active, in: [true, false]

  validates_each :gifts, allow_blank: true do |record, attr, values|
    values.each do |value|
      record.errors.add(attr, "includes the invalid gift '#{value}'") unless all_gifts.include?(value.to_sym)
    end
  end

  validate :pcs_must_have_a_player, :npcs_must_not_have_a_player, :only_pcs_can_be_active, :gladiators_must_be_npcs

  accepts_nested_attributes_for :attribute_set, :skill_set

  def is_pc?
    !npc
  end

  def is_npc?
    npc
  end

  def is_gladiator?
    gladiator
  end

  private

  def pcs_must_have_a_player
    errors.add(:player_id, "must be present for PCs") if is_pc? && !player_id
  end

  def npcs_must_not_have_a_player
    errors.add(:player_id, "cannot be present for PCs") if is_npc? && player_id
  end

  def only_pcs_can_be_active
    errors.add(:active, "only valid for PCs") if is_npc? && active
  end

  def gladiators_must_be_npcs
    errors.add(:gladiator, "must be NPC") if is_gladiator? && is_pc?
  end

  # Ideally this method would not exist, I believe. (Always set these things beforehand)
  def set_default_associations
    self.health        = Health.new        unless health.present?
    self.inventory     = Inventory.new     unless inventory.present?
    self.attribute_set = AttributeSet.new  unless attribute_set.present?
    self.skill_set     = SkillSet.new      unless skill_set.present?
    self.choice        = Choice.new        unless choice.present?
  end
end
