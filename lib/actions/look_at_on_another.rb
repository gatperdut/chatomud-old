module ChatoMud
  module Actions
    class LookAtOnAnother < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        character = @params[:character]
        target = @params[:target]

        character_controller = @character_controller.search_character_controller(character)

        return unless check_target_present(character_controller, "You do not see that person.")

        return unless check_equality(@character_controller, character_controller) || check_room_can_be_seen_by(@character_controller.room_controller, @character_controller, "It is way too dark.")

        target_controller = character_controller.search_item_controller(target, :in_inventory)

        return unless check_target_present(target_controller, "#{character_controller.short_desc} does not seem to own the '#{target[:word]}'")

        tx("#{target_controller.short_desc} (#{target_controller.location(@character_controller)}):\n#{target_controller.full_desc}")
      end
    end
  end
end
