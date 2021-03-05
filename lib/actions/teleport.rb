module ChatoMud
  module Actions
    class Teleport < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target  = @params[:target]
        room_id = @params[:room_id].to_i
        bang    = @params[:bang]

        character_controller = @character_controller.search_character_controller(target)
        return unless check_target_present(character_controller, "You cannot find that character.")

        return unless check_no_equality(@character_controller, character_controller, "\nUse GO to teleport yourself.\n")

        room_controller = @server.rooms_handler.find(room_id)

        return unless check_no_equality(character_controller.room_controller.id, room_controller.id, "\nThey are already in that room!.\n")

        if character_controller.group_controller.is_leading?(true) && !bang
          tx("\n#{character_controller.short_desc} is leading a group, which will be teleported as well. 'teleport #{target[:word]} #{room_id} !' to confirm.\n")
          return
        end

        if character_controller.group_controller.is_following?(true) && !bang
          tx("\n#{character_controller.short_desc} is a member of a group, #{personal(character_controller.physical_attr_controller.gender)} will abandon it. 'teleport #{target[:word]} #{room_id} !' to confirm.\n")
          return
        end

        return unless check_target_present(room_controller, "There is no room with such id.")

        if character_controller.group_controller.is_leading?(true)
          group_string = " and #{possessive(character_controller.physical_attr_controller.gender)} followers"
          disband = false
        elsif character_controller.group_controller.is_following?(true)
          character_controller.teleport(true)
          group_string = ", removing #{objective(character_controller.physical_attr_controller.gender)} from the group,"
          disband = true
        else
          group_string = ""
          disband = false
        end

        tx("You teleport #{character_controller.short_desc}#{group_string} to #{room_controller.title_formatted}.\n")

        character_controller.group_controller.group_members(true).each do |group_member|
          group_member.tx("\nYou are whisked away!.\n".red)
          group_member.teleport(disband)
          room_controller.accept_character(group_member, true)
          Actions::LookAround.new(@server, group_member, nil).exec
        end
      end
    end
  end
end
