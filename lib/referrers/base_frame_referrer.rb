module ChatoMud
  module Referrers
    class BaseFrameReferrer
      def find(roll, race)
        roll = roll.clamp(-191, 320)

        BaseFrame.where(race: race).where("score_limit <= ?", roll).last
      end

      def find_by_column(race, column)
        BaseFrame.where(race: race, column: column).first
      end
    end
  end
end
