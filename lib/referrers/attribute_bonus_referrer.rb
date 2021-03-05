module ChatoMud
  module Referrers
    class AttributeBonusReferrer
      def initialize
        @entries = AttributeBonus.all.reverse
      end

      def find(stat_value)
        previous = @entries.first
        @entries.each do |entry|
          return previous if entry.limit <= stat_value

          previous = entry
        end
      end
    end
  end
end
