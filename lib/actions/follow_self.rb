module ChatoMud
  module Actions
    class FollowSelf < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        unless @character_controller.group_controller.is_following?(true)
          tx("You are not following anybody.")
          return
        end

        if @character_controller.visibility_controller.is_visible?
          room_controller.emit_action_echo("follow_stop", { emitter: @character_controller })
        else
          tx("You stop following #{@character_controller.group_controller.following.short_desc}, undetected.")
        end

        @character_controller.group_controller.stop_following
      end
    end
  end
end
