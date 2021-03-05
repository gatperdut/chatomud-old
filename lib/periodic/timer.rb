require "mixins/periodic/calendar/definition"
require "mixins/periodic/healing_pulse/definition"
require "mixins/periodic/fuel_consumption_pulse/definition"
require "mixins/periodic/nourishment_burner/definition"

require "periodic/tasks/calendar"
require "periodic/tasks/healing_pulse"
require "periodic/tasks/fuel_consumption_pulse"
require "periodic/tasks/nourishment_burner"

module ChatoMud
  module Periodic
    class Timer
      include Mixins::Periodic::Calendar::Definition
      include Mixins::Periodic::HealingPulse::Definition
      include Mixins::Periodic::FuelConsumptionPulse::Definition
      include Mixins::Periodic::NourishmentBurner::Definition

      attr_reader :calendar

      def initialize(server)
        @calendar               = Tasks::Calendar.new(server)
        @healing_pulse          = Tasks::HealingPulse.new(server)
        @fuel_consumption_pulse = Tasks::FuelConsumptionPulse.new(server)
        @nourishment_burner     = Tasks::NourishmentBurner.new(server)

        @thread = nil

        @timestamp = nil

        first_iteration

        start_thread
      end

      def start_thread
        @thread = Thread.new(self, @server, @calendar, @healing_pulse, @fuel_consumption_pulse, @nourishment_burner) do |timer, server, calendar, healing_pulse, fuel_consumption_pulse, nourishment_burner|
          loop do
            @timestamp = Time.new.to_i

            calendar.tick               if must_tick(Mixins::Periodic::Calendar::Definition::REFRESH_INTERVAL)

            healing_pulse.tick          if must_tick(Mixins::Periodic::HealingPulse::Definition::REFRESH_INTERVAL)

            fuel_consumption_pulse.tick if must_tick(Mixins::Periodic::FuelConsumptionPulse::Definition::REFRESH_INTERVAL)

            nourishment_burner.tick     if must_tick(Mixins::Periodic::NourishmentBurner::Definition::REFRESH_INTERVAL)

            sleep(1)
          end
        end
      end

      def first_iteration
        calendar.tick
      end

      def bye
        @thread.terminate
      end

      private

      def must_tick(seconds)
        (@timestamp % seconds).zero?
      end
    end
  end
end
