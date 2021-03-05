module ChatoMud
  module Mixins
    module Actions
      module Checks
        module General
          def check_target_present(target_controller, message = nil)
            unless target_controller
              tx(message) if message
              return false
            end
            true
          end

          def check_target_not_present(target_controller, message = nil)
            if target_controller
              tx(message) if message
              return false
            end
            true
          end

          def check_count_is_positive(items, message = nil)
            unless items.count.positive?
              tx(message) if message
              return false
            end
            true
          end

          def check_length_is_within(measurable, min, max, message = nil)
            length = measurable.length

            valid = true

            valid = false if min.present? && length < min
            valid = false if max.present? && length > max

            unless valid
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
