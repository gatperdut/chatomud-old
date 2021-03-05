module ChatoMud
  module Mixins
    module Actions
      module Checks
        module LightSources
          def check_is_valid_liquid_fuel(liquid_fuel_req_controller, fluid, message = nil)
            unless liquid_fuel_req_controller.is_valid_fuel?(fluid)
              tx(message) if message
              return false
            end
            true
          end

          def check_is_valid_solid_fuel(solid_fuel_req_controller, item_controller, message = nil)
            unless solid_fuel_req_controller.is_valid_fuel?(item_controller)
              tx(message) if message
              return false
            end
            true
          end

          def check_is_fuelable(light_source_controller, message = nil)
            unless light_source_controller.requires_fuel?
              tx(message) if message
              return false
            end
            true
          end

          def check_requires_liquid_fuel(light_source_controller, message = nil)
            unless light_source_controller.requires_liquid_fuel?
              tx(message) if message
              return false
            end
            true
          end

          def check_requires_solid_fuel(light_source_controller, message = nil)
            unless light_source_controller.requires_solid_fuel?
              tx(message) if message
              return false
            end
            true
          end

          def check_light_is_eternal(light_source_controller, message = nil)
            unless light_source_controller.is_eternal?
              tx(message) if message
              return false
            end
            true
          end

          def check_light_is_not_eternal(light_source_controller, message = nil)
            if light_source_controller.is_eternal?
              tx(message) if message
              return false
            end
            true
          end

          def check_light_can_be_lit(light_source_controller, message = nil)
            unless light_source_controller.lifetime_left.positive?
              tx(message) if message
              return false
            end
            true
          end

          def check_light_is_lit(light_source_controller, message = nil)
            unless light_source_controller.is_lit?
              tx(message) if message
              return false
            end
            true
          end

          def check_light_is_unlit(light_source_controller, message = nil)
            unless light_source_controller.is_unlit?
              tx(message) if message
              return false
            end
            true
          end
        end
      end
    end
  end
end
