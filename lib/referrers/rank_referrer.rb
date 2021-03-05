module ChatoMud
  module Referrers
    class RankReferrer
      attr_reader :limited
      attr_reader :below_average
      attr_reader :standard
      attr_reader :above_average
      attr_reader :plus

      def initialize
        @limited       = Rank.where(rate: :limited).to_a
        @below_average = Rank.where(rate: :below_average).to_a
        @standard      = Rank.where(rate: :standard).to_a
        @above_average = Rank.where(rate: :above_average).to_a
        @plus          = Rank.where(rate: :plus).to_a
      end

      def find(rate, value)
        raise "invalid rank value #{value}" unless value.between?(0, 30)

        send("#{rate}").bsearch do |entry|
          entry.value >= value
        end
      end
    end
  end
end
