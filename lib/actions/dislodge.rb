require "mixins/body_parts/definition"

module ChatoMud
  module Actions
    class Dislodge < BaseAction
      include Mixins::BodyParts::Definition

      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        target = @params[:target]
        body_part = @params[:body_part]

        target_controller = @character_controller.search_character_controller(target)
        return unless check_target_present(target_controller, "You cannot find that character.")

        return unless check_stance_is_any_of(target_controller, [:sitting_or_resting], "#{target_controller.short_desc} must be sitting or resting.")

        unless all_body_parts.include?(body_part.to_sym)
          tx("That is not a valid body part.")
          return
        end

        wound_controllers = target_controller.health_controller.wounds_by_body_part(body_part, true)
        return unless check_count_is_positive(wound_controllers, "#{target_controller.short_desc} has nothing lodged there.")

        wound_controller = wound_controllers[0]

        return unless check_character_can_hold(@character_controller, nil, "You will need a free hand to do that.")

        missile_controller = wound_controller.inventory_controller.lodged_missile_controller

        wound_controller.dislodge_missile(@character_controller)

        room_controller.emit_action_echo("dislodge", { emitter: @character_controller, body_part: body_part, missile: missile_controller, target: target_controller })
      end
    end
  end
end
