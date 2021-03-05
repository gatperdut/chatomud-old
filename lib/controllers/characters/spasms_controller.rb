module ChatoMud
  module Controllers
    module Characters
      class SpasmsController
        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
        end

        def drop_carried_items
          @character_controller.room_controller.emit_action_echo("spasm_drop_all", { emitter: @character_controller, items: @character_controller.inventory_controller.carried_item_controllers })

          @character_controller.inventory_controller.drop_carried_items
        end
      end
    end
  end
end
