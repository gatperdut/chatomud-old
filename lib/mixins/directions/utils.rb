module ChatoMud
  module Mixins
    module Directions
      module Utils
        def abbreviature(direction)
          case direction
            when :north
              "n"
            when :east
              "e"
            when :south
              "s"
            when :west
              "w"
            when :up
              "u"
            when :down
              "d"
            when nil
              nil
            else
              raise "unknown direction"
          end
        end

        def opposite(direction)
          case direction
            when :north
              :south
            when :east
              :west
            when :south
              :north
            when :west
              :east
            when :up
              :ddown
            when :down
              :up
            else
              raise "unknown direction"
          end
        end

        def opposite_as_from(direction)
          case direction
            when :north
              "the south"
            when :east
              "the west"
            when :south
              "the north"
            when :west
              "the east"
            when :up
              "below"
            when :down
              "above"
            when nil
              nil
            else
              raise "unknown direction"
          end
        end
      end
    end
  end
end
