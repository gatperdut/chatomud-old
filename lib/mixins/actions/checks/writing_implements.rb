module ChatoMud
  module Mixins
    module Actions
      module Checks
        module WritingImplements
          def check_writing_implement_is_single_use(writing_implement_controller, message = nil)
            unless writing_implement_controller.is_single_use?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_implement_is_not_single_use(writing_implement_controller, message = nil)
            if writing_implement_controller.is_single_use?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_implement_is_charged(writing_implement_controller, message = nil)
            unless writing_implement_controller.is_charged?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_implement_is_not_charged(writing_implement_controller, message = nil)
            if writing_implement_controller.is_charged?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_implement_bears_picking_ink(writing_implement_controller, message = nil)
            unless writing_implement_controller.bears_picking_ink?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_implement_bears_dipping_ink(writing_implement_controller, message = nil)
            unless writing_implement_controller.bears_dipping_ink?
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
