module ChatoMud
  module Actions
    class Armor < BaseAction
      def exec
        tx("#{@character_controller.inventory_controller.list_armor}")
      end
    end
  end
end
