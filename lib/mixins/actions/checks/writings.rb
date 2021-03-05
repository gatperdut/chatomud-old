module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Writings
          def check_writing_is_blank(writing_controller, message = nil)
            if writing_controller.post_controller.has_content?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_is_not_blank(writing_controller, message = nil)
            unless writing_controller.post_controller.has_content?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_is_wipeable(writing_controller, message = nil)
            unless writing_controller.is_wipeable?
              tx(message) if message
              return false
            end
            true
          end

          def check_writing_is_not_wipeable(writing_controller, message = nil)
            if writing_controller.is_wipeable?
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
