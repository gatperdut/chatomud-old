require "mixins/reaches/definition"

class HornProperty < ApplicationRecord
  extend ChatoMud::Mixins::Reaches::Definition

  belongs_to :item

  enum reach: all_reaches

  validates :item, :echo, :reach, :action_echo_self, :action_echo_others, presence: true
end
