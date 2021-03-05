require "mixins/items/amounts"

module ChatoMud
  module Controllers
    module Items
      module Amounts
        class CapacityController
          include Mixins::Items::Amounts

          def initialize(light_source_controller, capacity)
            @light_source_controller = light_source_controller
            @capacity = capacity

            @warning_nearly_out_given = false
          end

          def handle_consume
            if is_empty?
              handle_consume_empty
            else
              @light_source_controller.reset_burndown
            end
          end

          def handle_reduced_burndown
            if @light_source_controller.burndown < 1
              consume(1)

              return if is_empty?
            end

            handle_consume_nearly_out if @light_source_controller.lifetime_left < 300
          end

          def current_portion_description
            fuel = @light_source_controller.fuel_name
            case percentage
              when 0.00
                "in need of fuel"
              when 0.01..0.20
                "almost out of #{fuel}"
              when 0.20..0.40
                "holding some #{fuel}"
              when 0.40..0.60
                "half full of #{fuel}"
              when 0.60..0.80
                "quite full of #{fuel}"
              when 0.80..0.99
                "mostly full of #{fuel}"
              when 1.00
                "full of #{fuel}"
              else
                raise "Invalid percentage for capacity current portion description."
            end
          end

          def model
            @capacity
          end

          private

          def handle_consume_empty
            @light_source_controller.item_controller.morphs_controller.sputter(true)

            @light_source_controller.zero_burndown

            @light_source_controller.turn_off
          end

          def handle_consume_nearly_out
            return if @warning_nearly_out_given

            @warning_nearly_out_given = true

            @light_source_controller.item_controller.morphs_controller.sputter(false)
          end
        end
      end
    end
  end
end
