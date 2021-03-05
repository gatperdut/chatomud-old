module ChatoMud
  module Actions
    class LookAt < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        ground = bool!(:ground)

        if ground
          controller = @character_controller.search_item_controller(target, :room)
        else
          controller = @character_controller.search_anything_controller(target)
        end

        return unless check_target_present(controller, ground ? "You do not see that object." : "You do not see that individual or object.")

        case controller.class.name.demodulize.to_sym
          when :NpcController, :PcController
            return unless check_room_can_be_seen_by(@character_controller.room_controller, @character_controller, "It is way too dark.")

            gender = @character_controller == controller ? :personal : controller.physical_attr_controller.gender
            tx(controller.full_desc(gender))
          when :ItemController
            unless check_is_in_character(controller)
              return unless check_room_can_be_seen_by(@character_controller.room_controller, @character_controller, "It is way too dark.")
            end
            tx("#{controller.short_desc} (#{controller.location(@character_controller)}):\n#{controller.full_desc}")
          when :FurnitureController
            return unless check_room_can_be_seen_by(@character_controller.room_controller, @character_controller, "It is way too dark.")

            tx(controller.full_desc)
          else
            raise "Unknown controller class when doing 'look at'."
        end
      end
    end
  end
end
