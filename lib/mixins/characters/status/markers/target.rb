module ChatoMud
  module Mixins
    module Characters
      module Status
        module Markers
          module Target
            def target_marker
              return "" unless @combat_controller.is_attacking?

              "[#{@combat_controller.target.short_desc.red} <#{@combat_controller.target.health_bar}>]"
            end
          end
        end
      end
    end
  end
end
