module ChatoMud
  module Referrers
    class CategoryRankReferrer
      attr_reader :limited
      attr_reader :below_average
      attr_reader :standard
      attr_reader :above_average
      attr_reader :plus

      def initialize
        @limited       = CategoryRank.where(rate: :limited).to_a
        @below_average = CategoryRank.where(rate: :below_average).to_a
        @standard      = CategoryRank.where(rate: :standard).to_a
        @above_average = CategoryRank.where(rate: :above_average).to_a
        @plus          = CategoryRank.where(rate: :plus).to_a
      end

      def find(rate, value)
        raise "invalid category rank value #{value}" unless value.between?(0, 30)

        send("#{rate}").bsearch do |entry|
          entry.value >= value
        end
      end
    end
  end
end
