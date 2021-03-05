require "mixins/body_parts/definition"

module ChatoMud
  module Actions
    class DislodgeSimple < BaseAction
      include Mixins::BodyParts::Definition

      def exec
        return unless can_perform?([:unconscious, :resting])

        body_part = @params[:body_part]

        return unless check_stance_is_any_of(@character_controller, [:sitting], "You must be sitting.")

        unless all_body_parts.include?(body_part.to_sym)
          tx("That is not a valid body part.")
          return
        end

        wound_controllers = @character_controller.health_controller.wounds_by_body_part(body_part, true)
        return unless check_count_is_positive(wound_controllers, "You have nothing lodged there.")

        wound_controller = wound_controllers[0]

        return unless check_character_can_hold(@character_controller, nil, "You will need a free hand to do that.")

        missile_controller = wound_controller.inventory_controller.lodged_missile_controller

        wound_controller.dislodge_missile(@character_controller)

        room_controller.emit_action_echo("dislodge_simple", { emitter: @character_controller, body_part: body_part, missile: missile_controller })
      end
    end
  end
end
