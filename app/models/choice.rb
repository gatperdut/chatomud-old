require "mixins/languages/definition"
require "mixins/scripts/definition"
require "mixins/characters/choices/stances/definition"
require "mixins/characters/choices/paces/definition"

class Choice < ApplicationRecord
  extend ChatoMud::Mixins::Languages::Definition
  extend ChatoMud::Mixins::Scripts::Definition
  extend ChatoMud::Mixins::Characters::Choices::Stances::Definition
  extend ChatoMud::Mixins::Characters::Choices::Paces::Definition

  belongs_to :character

  enum stance:   all_stances

  enum pace:     all_paces

  enum language: all_languages

  enum script:   all_scripts

  validates_inclusion_of :editor_echoes, in: [true, false]

  validates :character, :stance, :pace, :language, :script, presence: true
end
