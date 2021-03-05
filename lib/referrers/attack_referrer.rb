module ChatoMud
  module Referrers
    class AttackReferrer
      def find(base, roll, level)
        roll = 150 if roll > 150
        roll = 105 if roll > 105 && base == :brawl # remove this once 'improvised weapons' are introduced

        Attack.where(against: level, base: base).where("score_limit >= ?", roll).last
      end

      def maximum_miss_score(base, level)
        Attack.where(against: level, base: base, connects: false).order(score_limit: :desc)[0].score_limit
      end
    end
  end
end
