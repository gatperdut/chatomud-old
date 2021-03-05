module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Readable
          def check_is_readable_writable(target_controller, message = nil)
            unless target_controller.is_book? || target_controller.is_writing?
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
