module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module MissileUser
          # :held, :stowed
          def missile_controllers(where, missile_type)
            send("missile_controllers_#{where}", missile_type)
          end

          private

          def missile_controllers_held(missile_type)
            held_item_controllers.select do |held_item_controller|
              held_item_controller.is_missile? && held_item_controller.missile_stat_controller.is_missile_type?(missile_type)
            end
          end

          def missile_controllers_stowed(missile_type)
            result = []
            quiver_controllers(:worn).select do |quiver_controller|
              result << quiver_controller.inventory_controller.missile_controllers(missile_type)
            end
            result.flatten!
          end
        end
      end
    end
  end
end
