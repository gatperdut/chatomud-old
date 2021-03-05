module ChatoMud
  module Actions
    class Sit < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        furniture_controller = @character_controller.search_furniture_controller(target)

        return unless check_target_present(furniture_controller, "You do not see the '#{target[:word]}'.")

        unless furniture_controller.is_accommodation?
          tx("You cannot sit at #{furniture_controller.short_desc}.")
          return
        end

        if furniture_controller.is_full?
          tx("#{furniture_controller.short_desc} seems to be full.")
          return
        end

        if position_controller.is_sitting_or_resting?
          if position_controller.is_at?(furniture_controller)
            tx("You are already sitting at #{furniture_controller.short_desc}.")
          elsif position_controller.is_accommodated?
            tx("You will need to stand up from #{position_controller.furniture_controller.short_desc} first.")
          else
            tx("You will need to stand up first.")
          end
          return
        end

        interrupt_ranged_weapon_handling

        room_controller.emit_action_echo("sit", { emitter: @character_controller, at: furniture_controller })
        position_controller.sit(furniture_controller)
      end
    end
  end
end
