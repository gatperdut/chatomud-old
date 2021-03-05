module ChatoMud
  module Actions
    class Go < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        bang = @params[:bang]

        room_controller = nil
        if @params[:is_room]
          room_id = @params[:room_id].to_i
          room_controller = @server.rooms_handler.find(room_id)
          return unless check_target_present(room_controller, "There is no room with such id.")
        else
          name = @params[:name].to_s
          character_controller = @server.characters_handler.find_by_name(name)
          return unless check_target_present(character_controller, "There is no character with such name.")

          room_controller = character_controller.room_controller
        end

        return unless check_no_equality(@character_controller.room_controller.id, room_controller.id, "\nYou are already in that room!\n")

        if @character_controller.group_controller.is_leading?(true) && !bang
          tx("You are leading a group, which will be transfered as well. 'go #{room_id} !' to confirm.")
          return
        end

        if @character_controller.group_controller.is_following?(true) && !bang
          tx("You are member of a group, which you will abandon. 'go #{room_id} !' to confirm.")
          return
        end

        if @character_controller.group_controller.is_leading?(true)
          group_string = " with your followers"
          disband = false
        elsif @character_controller.group_controller.is_following?(true)
          disband = true
          group_string = " abandoning your group"
        else
          disband = false
          group_string = ""
        end

        tx("You go to #{room_controller.title_formatted}#{group_string}.")

        @character_controller.group_controller.group_members(true).each do |group_member|
          group_member.teleport(disband)
          room_controller.accept_character(group_member, true)
          Actions::LookAround.new(@server, group_member, nil).exec
        end
      end
    end
  end
end
