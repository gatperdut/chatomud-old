module ChatoMud
  module Mixins
    module Rooms
      module Illuminable
        def is_illuminated?
          light_source_in_room? || light_source_in_characters? || light_source_in_furniture?
        end

        private

        def light_source_in_room?
          any_lit?(@inventory_controller.find_light_source_controllers)
        end

        def light_source_in_characters?
          @character_controllers.any? do |character_controller|
            any_lit?(character_controller.inventory_controller.find_light_source_controllers)
          end
        end

        def light_source_in_furniture?
          @furniture_controllers.any? do |furniture_controller|
            any_lit?(furniture_controller.inventory_controller.find_light_source_controllers)
          end
        end

        def any_lit?(item_controllers)
          item_controllers.any? do |item_controller|
            item_controller.light_source_controller.is_lit?
          end
        end
      end
    end
  end
end
