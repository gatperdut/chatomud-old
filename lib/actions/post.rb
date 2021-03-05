require "mixins/slots/definition"

module ChatoMud
  module Actions
    class Post < BaseAction
      include Mixins::Slots::Definition

      def exec
        return unless can_perform?([:unconscious, :in_combat])

        return unless check_character_is_pc(@character_controller, "NPCs are not allowed to post.")

        target = @params[:target]
        speech = @params[:speech]

        item_controller = @character_controller.search_item_controller(target, :room)

        return unless check_target_present(item_controller, "You cannot find the '#{target[:word]}'.")

        return unless check_is_board(item_controller, "How could you possibly to that with #{item_controller.short_desc}.")

        return unless check_length_is_within(speech, 1, 80, "The headline must be between 1 and 80 characters long.")

        item_controller.board_controller.post(@character_controller, speech)
      end
    end
  end
end
