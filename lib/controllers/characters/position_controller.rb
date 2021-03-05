module ChatoMud
  module Controllers
    module Characters
      class PositionController
        attr_reader :position
        attr_reader :character_controller
        attr_reader :furniture_controller

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
          @position = :standing
          @furniture_controller = nil
        end

        def is_sitting?
          @position == :sitting
        end

        def is_standing?
          @position == :standing
        end

        def is_resting?
          @position == :resting
        end

        def sit(furniture_controller = nil)
          handle_in_combat
          take_place(furniture_controller) if furniture_controller
          @position = :sitting
        end

        def stand
          @position = :standing
          abandon_place if is_accommodated?
        end

        def rest
          handle_in_combat
          @position = :resting
        end

        def is_sitting_or_resting?
          is_sitting? || is_resting?
        end

        def is_accommodated?
          !!@furniture_controller
        end

        def is_at?(furniture_controller)
          @furniture_controller == furniture_controller
        end

        def position_description
          case @position
            when :standing
              "standing"
            when :sitting
              is_accommodated? ? "sitting at #{@furniture_controller.short_desc}" : "sitting on the ground"
            when :resting
              is_accommodated? ? "resting at #{@furniture_controller.short_desc}" : "resting on the ground"
            else
              raise "position description for unknown description"
          end
        end

        def abandon_place
          @furniture_controller.unaccommodate(self)
          @furniture_controller = nil
        end

        private

        def take_place(furniture_controller)
          @furniture_controller = furniture_controller
          @furniture_controller.accommodate(self)
        end

        def handle_in_combat
          @character_controller.combat_controller.stop_combat(false, true) if @character_controller.combat_controller.is_attacking?
        end
      end
    end
  end
end
