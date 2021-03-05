module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Equality
          def check_equality(first_controller, second_controller, message = nil)
            unless first_controller == second_controller
              tx(message) if message
              return false
            end
            true
          end

          def check_no_equality(first_controller, second_controller, message = nil)
            if first_controller == second_controller
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
