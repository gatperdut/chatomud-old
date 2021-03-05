require "mixins/periodic/calendar/definition"
require "mixins/periodic/calendar/utils"

module ChatoMud
  module Periodic
    module Tasks
      class Calendar
        include ChatoMud::Mixins::Periodic::Calendar::Definition
        include ChatoMud::Mixins::Periodic::Calendar::Utils

        def initialize(server)
          @server = server

          @data = nil

          @day_period_name = nil
        end

        def tick
          new_data = rl_time_to_ig_time(Time.new)

          if @data
            result = day_period_change_echo(@data, new_data)

            echo             = result[0]
            @day_period_name = result[1]

            @server.rooms_handler.broadcast_action_echo(echo, nil) if echo
          else
            @day_period_name = day_period_name(new_data)
          end

          @data = new_data
        end

        def time_string
          "It is #{day_period_name(@data)} (#{hour(@data)}) on #{day_name(@data, true)} of the year #{@data[:year]} of the Steward's Reckoning."
        end

        def compact_time_string(rl_time)
          ig_time = rl_time_to_ig_time(rl_time)

          "#{day_name(ig_time, false)} #{hour(ig_time)}"
        end

        def is_daylight_period?
          LIGHT_DAY_PERIOD_NAMES.include?(@day_period_name)
        end

        def rl_time_to_ig_time(rl_time)
          rl_seconds = rl_time.yday * SECS_PER_RL_DAY + rl_time.hour * SECS_PER_RL_HOUR + rl_time.min * SECS_PER_RL_MINUTE + rl_time.sec
          ig_seconds = rl_seconds % SECS_PER_IG_YEAR

          ig_year  = IG_START_YEAR + (rl_time.year - RL_START_YEAR) * 4 + rl_time.month / 3 + 1
          ig_yday  = (ig_seconds / SECS_PER_IG_DAY) + 1
          ig_month = month_number(ig_yday)

          ig_hour   = (ig_seconds % SECS_PER_IG_DAY)    / SECS_PER_IG_HOUR
          ig_minute = (ig_seconds % SECS_PER_IG_HOUR)   / SECS_PER_IG_MINUTE
          ig_second = (ig_seconds % SECS_PER_IG_MINUTE) * 4

          ig_day_minute = ig_hour * 60 + ig_minute

          {
            year:    ig_year,
            month:   ig_month,
            yday:    ig_yday,
            mday:    month_day(ig_yday),
            hour:    ig_hour,
            hminute: ig_minute,
            dminute: ig_day_minute,
            second:  ig_second
          }
        end
      end
    end
  end
end
