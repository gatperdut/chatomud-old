module ChatoMud
  module Mixins
    module Characters
      module Status
        module Markers
          module Visibility
            def visibility_marker
              @visibility_controller.is_invisible? ? "#" : ""
            end
          end
        end
      end
    end
  end
end
