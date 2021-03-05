module ChatoMud
  module Actions
    class Direction < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting, :in_combat])

        direction = @params[:towards].keys[0]
        # TODO: handle the emote.
        # emote     = @params[:emote]
        bang      = @params[:bang]

        interrupt_ranged_weapon_handling

        if @character_controller.walking_controller.is_walking?
          if direction == @character_controller.walking_controller.direction
            tx("You are already on your way.")
          else
            @character_controller.walking_controller.stop_walking
            if @character_controller.visibility_controller.is_invisible?
              @character_controller.tx("You turn around, undetected.")
            else
              room_controller.emit_action_echo("turn_around", { emitter: @character_controller })
            end
          end
        else
          new_room_controller = room_controller.send("room_#{direction}")

          return unless check_target_present(new_room_controller, "You cannot go that way.")

          return unless check_has_enough_exhaustion_travel(@character_controller, "You are too exhausted.")

          if @character_controller.group_controller.is_leading?(true)
            if @character_controller.group_controller.all_followers_can_walk?(true)
              do_group_walk(direction)
            elsif bang.present?
              do_group_walk(direction)
            else
              tx("Some members of your group will not be able to follow. '#{direction} !' to confirm.")
            end
          elsif @character_controller.group_controller.is_following?
            if bang.present?
              @character_controller.group_controller.stop_following
              do_walk(@character_controller, direction)
            else
              tx("Are you sure you want to abandon your group? '#{direction} !' to confirm.")
            end
          else
            do_walk(@character_controller, direction)
          end
        end
      end

      def do_group_walk(direction)
        @character_controller.group_controller.group_members(true).each do |group_member|
          if group_member.can_walk?
            do_walk(group_member, direction)
          else
            if group_member.health_controller.is_conscious?
              group_member.tx("#{group_member.group_controller.following.short_desc} leaves you behind.")
            end
            group_member.group_controller.stop_following
          end
        end
      end

      def do_walk(character_controller, direction)
        if character_controller.visibility_controller.is_invisible?
          character_controller.tx("You leave #{direction}ward, undetected.")
        else
          character_controller.room_controller.emit_action_echo("direction", { emitter: character_controller, direction: direction, emote: nil, fleeing: false })
        end
        character_controller.walking_controller.start_walking(direction, false)
      end
    end
  end
end
