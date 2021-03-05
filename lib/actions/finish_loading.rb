module ChatoMud
  module Actions
    class FinishLoading < BaseAction
      def exec
        missile_controller = @params[:missile]
        from = @params[:from]

        ranged_weapon_controller = @character_controller.inventory_controller.ranged_weapon_controllers(:wielded, false)[0]

        case from
          when :from_hand
            ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.accept_item(missile_controller, true)
          when :from_quiver
            missile_controller = handle_spawned_stack(missile_controller, 1, ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller)
          else
            raise "unknown from when finishing load"
        end

        slot = ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.can_remain_loaded? ? ranged_weapon_controller.slot : :w2hands

        ranged_weapon_controller.set_slot(slot, true)

        @character_controller.room_controller.emit_action_echo("finish_loading", { emitter: @character_controller, missile: missile_controller })

        @character_controller.load_controller.done_loading
      end
    end
  end
end
