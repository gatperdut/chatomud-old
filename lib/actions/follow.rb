module ChatoMud
  module Actions
    class Follow < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]

        character_controller = @character_controller.search_character_controller(target)

        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "You cannot target yourself this way - 'follow self' to abandon your group.")

        if @character_controller.group_controller.is_member?(character_controller)
          if @character_controller.group_controller.is_leading?
            tx("You are leading #{objective(character_controller.physical_attr_controller.gender)} already. You can follow #{objective(character_controller.physical_attr_controller.gender)} once #{personal(character_controller.physical_attr_controller.gender)} stops following you.")
          elsif character_controller.group_controller.is_leading?
            tx("You are already following #{character_controller.short_desc}.")
          else
            tx("You are already following #{possessive(character_controller.physical_attr_controller.gender)} leader, #{character_controller.group_controller.following.short_desc}.")
          end

          return
        end

        if @character_controller.group_controller.is_leading?
          group_members = @character_controller.group_controller.group_members
          # Not sure how to handle this for invisible leaders.
          room_controller.emit_action_echo("follow_new_leader", { group_members: group_members, target: character_controller })
          group_members.each do |group_member_controller|
            group_member_controller.group_controller.follow(character_controller)
          end
          return
        end

        if character_controller.group_controller.is_leading? || !character_controller.group_controller.is_grouped?
          if @character_controller.visibility_controller.is_visible?
            room_controller.emit_action_echo("follow_direct", { emitter: @character_controller, target: character_controller })
          else
            @character_controller.tx("You fall into stride with #{@character_controller.short_desc}, undetected.")
          end
        else
          if @character_controller.visibility_controller.is_visible?
            room_controller.emit_action_echo("follow_proxy", { emitter: @character_controller, target: character_controller })
          else
            @character_controller.tx("You fall into stride with the leader of #{character_controller.short_desc}, #{character_controller.group_controller.following.short_desc}, undetected.")
          end
        end

        @character_controller.group_controller.follow(character_controller)
      end
    end
  end
end
