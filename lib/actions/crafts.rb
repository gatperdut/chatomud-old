module ChatoMud
  module Actions
    class Crafts < BaseAction
      def exec
        return unless can_perform?([:unconscious, :sitting_or_resting])

        category = @params[:category].to_s
        name     = @params[:name].to_s

        craft = Craft.find_by(category: category, name: name)

        return unless check_target_present(craft, "You have no knowledge of such craft.")

        if @character_controller.crafts_controller.is_crafting?
          tx("You are already crafting.\n")
          return
        end

        @character_controller.crafts_controller.start_crafting(craft)
      end
    end
  end
end
