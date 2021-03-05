require "mixins/slots/definition"
require "mixins/slots/utils"

module ChatoMud
  module Actions
    class DirectedWear < BaseAction
      include Mixins::Slots::Utils

      extend Mixins::Slots::Definition

      def exec
        return unless can_perform?([:unconscious])

        target = @params[:target]
        slot = @params[:slot]

        slot = slot.to_sym if slot

        item_controller = @character_controller.search_item_controller(target, :held)
        unless item_controller
          tx("You are not holding the '#{target[:word]}'.")
          return
        end

        unless item_controller.is_wearable?
          tx("#{item_controller.short_desc} cannot be worn.")
          return
        end

        unless is_valid_slot?(slot)
          tx("'#{slot}' is not a valid wearloc.")
          return
        end

        unless item_controller.is_wearable_in?(slot)
          tx("#{item_controller.short_desc} cannot be worn #{slot_description(slot, :personal)}.")
          return
        end

        unless @character_controller.inventory_controller.is_slot_free?(slot)
          tx("You are already wearing something #{slot_description(slot, :personal)}.")
          return
        end

        interrupt_ranged_weapon_handling

        item_controller.set_slot(slot, true)
        room_controller.emit_action_echo("wear", { emitter: @character_controller, target: item_controller, slot: slot })
      end
    end
  end
end
