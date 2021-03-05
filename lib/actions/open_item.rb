module ChatoMud
  module Actions
    class OpenItem < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        ground = bool!(:ground)

        item_controller = @character_controller.search_item_or_furniture_controller(target, ground)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        if !check_is_container(item_controller) && !check_is_book(item_controller)
          tx("#{item_controller.short_desc} is nothing you could open.")
          return
        end

        if item_controller.is_container?
          return unless check_is_closable(item_controller.inventory_controller, "#{item_controller.short_desc} cannot be opened.")

          return unless check_container_or_door_is_closed(item_controller.inventory_controller.lid_controller, "#{item_controller.short_desc} is already open.")

          if check_is_lockable(item_controller.inventory_controller.lid_controller)
            return unless check_is_unlocked(item_controller.inventory_controller.lid_controller.lock_controller, "#{item_controller.short_desc} is locked.")
          end
        end

        if item_controller.is_book?
          return unless check_book_is_closed(item_controller.book_controller, "#{item_controller.short_desc} is already open.")
        end

        interrupt_ranged_weapon_handling

        if item_controller.is_container?
          item_controller.inventory_controller.lid_controller.open
        end

        if item_controller.is_book?
          item_controller.book_controller.open
        end

        room_controller.emit_action_echo("open_item", { emitter: @character_controller, target: item_controller })
      end
    end
  end
end
