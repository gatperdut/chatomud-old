require "mixins/characters/choices/paces/definition"

module ChatoMud
  module Mixins
    module Characters
      module Choices
        module Paces
          module Utils
            include Mixins::Characters::Choices::Paces::Definition

            def pace_travel_time_multiplier(pace)
              case pace.to_sym
                when :crawl
                  3.00
                when :trudge
                  2.00
                when :walk
                  1.00
                when :jog
                  0.66
                when :sprint
                  0.33
                when :dash
                  0.20
                else
                  raise "Unknown pace when finding pace travel time multiplier."
              end
            end

            def pace_travel_exhaustion_base(pace)
              case pace.to_sym
                when :crawl
                  1
                when :trudge
                  1
                when :walk
                  2
                when :jog
                  4
                when :sprint
                  8
                when :dash
                  12
                else
                  raise "Unknown pace when finding pace travel exhaustion base."
              end
            end

            def hits_travel_exhaustion_multiplier(hits_percentage)
              case hits_percentage
                when 0.0..0.5
                  4
                when 0.5..0.75
                  2
                else
                  1
              end
            end

            def allowed_paces(encumbrance_penalty)
              case encumbrance_penalty
                when 0..10
                  all_paces.first(6)
                when 11..25
                  all_paces.first(5)
                when 26..40
                  all_paces.first(4)
                when 41..65
                  all_paces.first(3)
                when 66..100
                  all_paces.first(2)
                when 101..Float::INFINITY
                  all_paces.first(1)
              end
            end
          end
        end
      end
    end
  end
end
