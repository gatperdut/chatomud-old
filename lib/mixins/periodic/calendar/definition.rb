module ChatoMud
  module Mixins
    module Periodic
      module Calendar
        module Definition
          REFRESH_INTERVAL = 5 # Seconds.

          # Oxford, actually.
          LATITUDE  = 51.7520
          LONGITUDE = 1.2577

          SECS_PER_RL_MINUTE = 60
          SECS_PER_RL_HOUR   = SECS_PER_RL_MINUTE * 60
          SECS_PER_RL_DAY    = SECS_PER_RL_HOUR * 24
          SECS_PER_RL_YEAR   = SECS_PER_RL_DAY * 365

          RL_START_YEAR = 2017
          IG_START_YEAR = 2470 # Steward's Reckoning, Third Age.

          SECS_PER_IG_MINUTE = 15
          SECS_PER_IG_HOUR   = SECS_PER_IG_MINUTE * 60
          SECS_PER_IG_DAY    = SECS_PER_IG_HOUR * 24
          SECS_PER_IG_YEAR   = SECS_PER_IG_DAY * 365

          LIGHT_DAY_PERIOD_NAMES = [
            "dawn",
            "early morning",
            "morning",
            "late morning",
            "midday",
            "early afternoon",
            "afternoon",
            "late afternoon",
            "dusk"
          ].freeze
        end
      end
    end
  end
end
