module ChatoMud
  module Mixins
    module Characters
      # Possible rename to KwordSearcher and move within 'searching' folder along with searcher_itc
      module Searcher
        def search_character_controller(kword)
          @room_controller.find_character_controller(kword)
        end

        # :held, :worn, :worn_or_wielded, :in_inventory, :room, :held_or_room, :anywhere, :sheaths, :sheathable, :sheathed, :wielded, :carried
        def search_item_controller(kword, where)
          send("search_item_controller_#{where}", kword)
        end

        def search_furniture_controller(kword)
          @room_controller.find_furniture_controller(kword)
        end

        def search_item_or_furniture_controller(target, ground)
          if ground
            item_controller = search_item_controller(target, :room)
          else
            item_controller = search_item_controller(target, :anywhere)
            item_controller ||= search_furniture_controller(target)
          end

          item_controller
        end

        def search_anything_controller(kword)
          item_controller = search_item_controller(kword, :anywhere)
          return item_controller if item_controller

          item_controller = search_character_controller(kword)
          return item_controller if item_controller

          search_furniture_controller(kword)
        end

        private

        def search_item_controller_held(kword)
          @inventory_controller.find_held_item_controller(kword)
        end

        def search_item_controller_wielded(kword)
          @inventory_controller.find_wielded_item_controller(kword)
        end

        def search_item_controller_held_or_wielded(kword)
          item_controller = search_item_controller_held(kword)
          return item_controller if item_controller

          search_item_controller_wielded(kword)
        end

        def search_item_controller_carried(kword)
          @inventory_controller.find_carried_item_controller(kword)
        end

        def search_item_controller_worn(kword)
          @inventory_controller.find_worn_item_controller(kword)
        end

        def search_item_controller_worn_or_wielded(kword)
          @inventory_controller.find_worn_or_wielded_item_controller(kword)
        end

        def search_item_controller_sheath(kword)
          @inventory_controller.find_sheath_item_controller(kword)
        end

        def search_item_controller_sheathed(kword)
          @inventory_controller.find_sheathed_item_controller(kword)
        end

        def search_item_controller_sheathable(kword)
          @inventory_controller.find_sheathable_item_controller(kword)
        end

        def search_item_controller_in_inventory(kword)
          @inventory_controller.find_any_item_controller(kword)
        end

        def search_item_controller_room(kword)
          @room_controller.inventory_controller.find_item_controller(kword)
        end

        def search_item_controller_held_or_room(kword)
          item_controller = search_item_controller_held(kword)
          return item_controller if item_controller

          search_item_controller_room(kword)
        end

        def search_item_controller_anywhere(kword)
          item_controller = search_item_controller_in_inventory(kword)
          return item_controller if item_controller

          search_item_controller_room(kword)
        end
      end
    end
  end
end
