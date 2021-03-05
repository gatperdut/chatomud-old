require "controllers/items/solid_fuel_req_controller"
require "controllers/items/liquid_fuel_req_controller"
require "controllers/items/amounts/capacity_controller"

require "mixins/describable/light_source"
require "mixins/periodic/fuel_consumption_pulse/definition"

module ChatoMud
  module Controllers
    module Items
      class LightSourceController
        include Mixins::Describable::LightSource
        include Mixins::Periodic::FuelConsumptionPulse::Definition

        attr_reader :item_controller
        attr_reader :solid_fuel_req_controller
        attr_reader :liquid_fuel_req_controller
        attr_reader :capacity_controller

        def initialize(server, item_controller, light_source)
          @server = server
          @item_controller = item_controller
          @light_source = light_source

          @solid_fuel_req_controller  = light_source.solid_fuel_req  ? SolidFuelReqController.new(server, self, light_source.solid_fuel_req)   : nil
          @liquid_fuel_req_controller = light_source.liquid_fuel_req ? LiquidFuelReqController.new(server, self, light_source.liquid_fuel_req) : nil

          @capacity_controller = light_source.capacity ? Amounts::CapacityController.new(self, light_source.capacity) : nil
        end

        def requires_solid_fuel?
          !!@solid_fuel_req_controller
        end

        def requires_liquid_fuel?
          !!@liquid_fuel_req_controller
        end

        def requires_fuel?
          requires_solid_fuel? || requires_liquid_fuel?
        end

        def has_capacity?
          !!@capacity_controller
        end

        def is_eternal?
          !has_capacity? && !requires_fuel?
        end

        def is_throw_away?
          has_capacity? && !requires_fuel?
        end

        def lifetime_left
          [@capacity_controller.current - 1, 0].max * efficiency + burndown
        end

        def reduce_lifetime
          return if is_eternal?

          return if is_unlit?

          @light_source.burndown = @light_source.burndown - Mixins::Periodic::FuelConsumptionPulse::Definition::REFRESH_INTERVAL * 4

          @capacity_controller.handle_reduced_burndown
        end

        def reset_burndown
          @light_source.burndown = @light_source.burndown + @light_source.efficiency
        end

        def zero_burndown
          @light_source.burndown = 0
        end

        def fuel_name
          return "fuel" if requires_solid_fuel?

          @capacity_controller.fluid_colorized if requires_liquid_fuel?
        end

        def efficiency
          @light_source.efficiency
        end

        def burndown
          @light_source.burndown
        end

        def is_lit?
          @light_source.lit
        end

        def is_unlit?
          !is_lit?
        end

        def turn_on
          @light_source.lit = true
          @light_source.save!
        end

        def turn_off
          @light_source.lit = false
          @light_source.save!
        end

        def must_be_held_to_light
          @light_source.must_be_held_to_light
        end

        def toggle
          @light_source.lit = !@light_source.lit
        end
      end
    end
  end
end
