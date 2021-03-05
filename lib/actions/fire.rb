require "mixins/directions/utils"

module ChatoMud
  module Actions
    class Fire < BaseAction
      include Mixins::Directions::Utils

      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :in_combat])

        return unless check_is_aiming(@character_controller, "You need to aim first.")

        target_controller = @character_controller.aim_controller.target_info[:target]

        target_controller.interrupt_editing

        room_controller.emit_action_echo("fire", { emitter: @character_controller, target: target_controller })

        @character_controller.aim_controller.fire

        @character_controller.aim_controller.done_aiming
      end
    end
  end
end
