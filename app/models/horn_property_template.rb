require "mixins/reaches/definition"

class HornPropertyTemplate < ApplicationRecord
  extend ChatoMud::Mixins::Reaches::Definition

  belongs_to :item_template

  enum reach: all_reaches

  validates :item_template, :echo, :reach, :action_echo_self, :action_echo_others, presence: true
end
