module ChatoMud
  module Controllers
    module Items
      class HornPropertyController
        def initialize(server, item_controller, horn_property)
          @server = server
          @item_controller = item_controller
          @horn_property = horn_property
        end

        def echo
          @horn_property.echo
        end

        def action_echo_self
          @horn_property.action_echo_self
        end

        def action_echo_others
          @horn_property.action_echo_others
        end

        def reach
          @horn_property.reach.to_sym
        end
      end
    end
  end
end
