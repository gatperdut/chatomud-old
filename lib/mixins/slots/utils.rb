require "mixins/slots/definition"
require "mixins/characters/physical_attrs/genders/utils"

module ChatoMud
  module Mixins
    module Slots
      module Utils
        extend Definition

        include Characters::PhysicalAttrs::Genders::Utils

        def is_valid_slot?(slot)
          self.class.worn_slots.include?(slot)
        end

        def slot_description(slot, gender)
          pronoun = possessive(gender)
          case slot.to_sym
            when :head
              "on #{pronoun} head"
            when :torso
              "around #{pronoun} torso"
            when :arms
              "on #{pronoung} arms"
            when :lshoulder
              "on #{pronoun} left shoulder"
            when :rshoulder
              "on #{pronoun} right shoulder"
            when :lhand
              "held in #{pronoun} left hand"
            when :rhand
              "held in #{pronoun} right hand"
            when :hands
              "worn on hands"
            when :wlhand
              "wielded in left hand"
            when :wrhand
              "wielded in right hand"
            when :w2hands
              "wielded in both hands"
            when :lwrist
              "around #{pronoun} left wrist"
            when :rwrist
              "around #{pronoun} right wrist"
            when :legs
              "on #{pronoun} legs"
            when :lankle
              "around #{pronoun} left ankle"
            when :rankle
              "around #{pronoun} right ankle"
            when :feet
              "on #{pronoun} feet"
            else
              raise "unknown wearloc '#{slot}'"
          end
        end
      end
    end
  end
end
