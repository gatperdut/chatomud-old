module ChatoMud
  module Actions
    class LookIn < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        # TODO: handle the ground switch.
        # ground = bool!(:ground)

        @controller = @character_controller.search_item_controller(target, :anywhere)
        @controller ||= @character_controller.search_furniture_controller(target)

        return unless check_target_present(@controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_in_character(@controller) || check_room_can_be_seen_by(@character_controller.room_controller, @character_controller, "It is way too dark.")

        if @controller.is_item_controller? && @controller.is_consumable?
          tx_consumable_info
          return
        end

        return unless check_is_container(@controller, "#{@controller.short_desc} is not a container.")

        if check_is_closable(@controller.inventory_controller)
          return unless check_container_or_door_is_open(@controller.inventory_controller.lid_controller, "#{@controller.short_desc} is closed.")
        end

        return unless check_has_content(@controller.inventory_controller, "#{@controller.short_desc} is empty.")

        location_info = @controller.is_item_controller? ? " (#{@controller.location(@character_controller)})" : ""

        tx("#{@controller.short_desc}#{location_info} contains:\n#{@controller.inventory_controller.list_inventory(:short_desc)}")
      end

      private

      # TODO: Why is this here? describable:item should take care of this.
      def tx_consumable_info
        if @controller.is_edible?
          tx("It is #{@controller.edible_summary}.")
          return
        end

        return unless @controller.is_fillable?

        tx("It is #{@controller.fillable_summary}.")
      end
    end
  end
end
