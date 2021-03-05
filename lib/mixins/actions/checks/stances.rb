module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Stances
          def check_stance_is_any_of(target_controller, stances, message = nil)
            stances.each do |stance|
              return true if target_controller.position_controller.send("is_#{stance}?")
            end

            tx(message) if message
            false
          end

          def check_stance_is_none_of(target_controller, stances, message = nil)
            stances.each do |stance|
              if target_controller.position_controller.send("is_#{stance}?")
                tx(message) if message
                return false
              end
            end

            true
          end
        end
      end
    end
  end
end
