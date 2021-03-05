require "mixins/characters/physical_attrs/races/definition"
require "mixins/characters/physical_attrs/genders/definition"

module ChatoMud
  module Referrers
    class FrameModifierReferrer
      include Mixins::Characters::PhysicalAttrs::Races::Definition
      include Mixins::Characters::PhysicalAttrs::Genders::Definition

      attr_reader :valid_labels

      def initialize
        set_valid_labels
      end

      def find(roll, race, gender)
        roll = roll.clamp(1, 100)

        FrameModifier.where(race: race, gender: gender).where("score_limit <= ?", roll).last
      end

      private

      def set_valid_labels
        @valid_labels = {}

        all_races.each do |race|
          @valid_labels[race] = {}
          all_genders.each do |gender|
            gender = :male if gender == :neuter
            @valid_labels[race][gender] = FrameModifier.where(race: race, gender: gender).distinct.pluck(:label)
          end
        end
      end
    end
  end
end
