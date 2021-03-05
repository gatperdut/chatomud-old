module ChatoMud
  module Mixins
    module Describable
      module Closable
        def closable_summary
          lid_text  = @inventory_controller.lid_controller.is_open? ? "It is open" : "It is closed"
          lock_text = @inventory_controller.lid_controller.is_lockable? ? ", and it has a lock." : "."
          "#{lid_text}#{lock_text}"
        end
      end
    end
  end
end
