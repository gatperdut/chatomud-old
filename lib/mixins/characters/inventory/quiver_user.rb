module ChatoMud
  module Mixins
    module Characters
      module Inventory
        module QuiverUser
          # :worn
          def quiver_controllers(where)
            send("quiver_controllers_#{where}")
          end

          private

          def quiver_controllers_worn
            worn_item_controllers.select(&:is_quiver?)
          end
        end
      end
    end
  end
end
