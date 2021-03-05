module ChatoMud
  module Controllers
    module Items
      class MorphsController
        def initialize(server, item_controller)
          @server          = server
          @item_controller = item_controller
        end

        def sputter(goes_out)
          send("sputter_on_#{@item_controller.container_type}", goes_out)
        end

        private

        def sputter_on_room(goes_out)
          room_controller = @item_controller.containing_inventory_controller.owner_controller

          room_controller.emit_action_echo("morph_sputter", { emitter: @item_controller, location: :room, goes_out: goes_out })
        end

        def sputter_on_character(goes_out)
          character_controller = @item_controller.containing_inventory_controller.owner_controller

          character_controller.room_controller.emit_action_echo("morph_sputter", { emitter: @item_controller, location: :character, goes_out: goes_out, character: character_controller })
        end

        def sputter_on_furniture(goes_out)
          furniture_controller = @item_controller.containing_inventory_controller.owner_controller

          furniture_controller.room_controller.emit_action_echo("morph_sputter", { emitter: @item_controller, location: :furniture, goes_out: goes_out, furniture: furniture_controller })
        end

        def sputter_on_item(goes_out)
          # Nothing. Should not even happen.
        end
      end
    end
  end
end
