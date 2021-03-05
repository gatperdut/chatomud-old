module ChatoMud
  module Mixins
    module Random
      module Utils
        # Possible values are:
        # :high_open_ended => can explode into the positives.
        # :low_open_ended  => can explode into the negatives.
        # :open_ended      => can explode both into the positives and the negatives (default value).
        # :closed          => does not explode (1 to 100).
        def d100(explode = :open_ended)
          roll = rand(1..100)

          return roll if explode == :closed

          return roll if roll >=  6 && roll <= 95

          return roll if roll < 6 && explode == :high_open_ended

          return roll if roll > 95 && explode == :low_open_ended

          direction = roll < 6 ? :negative : :positive

          loop do
            additional = d100(:closed)

            case direction
              when :positive
                roll += additional
              when :negative
                roll -= additional
            end

            break if additional <= 95
          end

          roll
        end
      end
    end
  end
end
