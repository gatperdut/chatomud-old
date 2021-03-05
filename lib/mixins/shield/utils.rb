module ChatoMud
  module Mixins
    module Shield
      module Utils
        def melee_bonus_for(variant)
          case variant
            when :wall
              30
            when :full
              25
            when :normal
              20
            when :target
              20
            else
              raise "unknown shield variant '#{variant}'"
          end
        end

        def ranged_bonus_for(variant)
          case variant
            when :wall
              40
            when :full
              25
            when :normal
              20
            when :target
              10
            else
              raise "unknown shield variant '#{variant}'"
          end
        end

        def max_opponents_blocked_for(variant)
          case variant
            when :wall
              2
            when :full
              2
            when :normal
              1
            when :target
              1
            else
              raise "unknown shield variant '#{variant}'"
          end
        end
      end
    end
  end
end
