require "mixins/fluids/definition"

module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Amounts
          include ChatoMud::Mixins::Fluids::Definition

          def check_is_valid_amount(amount, message = nil)
            if amount && amount < 1
              tx(message) if message
              return false
            end
            true
          end

          def check_has_amount_of(amount_controller, count, message = nil)
            unless amount_controller.current == count
              tx(message) if message
              return false
            end
            true
          end

          def check_has_amount_of_at_least(amount_controller, amount, message = nil)
            unless amount_controller.has_at_least?(amount)
              tx(message) if message
              return false
            end
            true
          end

          def check_amount_is_positive(amount_controller, message = nil)
            unless amount_controller.has_some?
              tx(message) if message
              return false
            end
            true
          end

          def check_amount_is_not_max(amount_controller, message = nil)
            if amount_controller.is_full?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_drinkable(amount_controller, message = nil)
            unless is_fluid_drinkable?[amount_controller.fluid.to_sym]
              tx(message) if message
              return false
            end
            true
          end

          def check_fluids_match(first_amount_controller, second_amount_controller, message = nil)
            unless first_amount_controller.fluid == second_amount_controller.fluid
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
