module ChatoMud
  module Mixins
    module Actions
      module Checks
        module InkSources
          def check_ink_source_is_picking(ink_source_controller, message = nil)
            unless ink_source_controller.is_picking_ink_source?
              tx(message) if message
              return false
            end
            true
          end

          def check_ink_source_is_dipping(ink_source_controller, message = nil)
            unless ink_source_controller.is_dipping_ink_source?
              tx(message) if message
              return false
            end
            true
          end

          def check_ink_source_has_charges_left(ink_source_controller, message = nil)
            unless ink_source_controller.has_charges_left?
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
