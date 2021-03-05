module ChatoMud
  module Mixins
    module Characters
      module Status
        module Markers
          module Fleeing
            def fleeing_marker
              return "" unless @combat_controller.is_fleeing?

              "<" << "fleeing".yellow << ">"
            end
          end
        end
      end
    end
  end
end
