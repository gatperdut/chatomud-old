module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_aim_simple(params)
            emitter       = params[:emitter]
            target_info   = params[:target_info]

            return unless can_see_action?(emitter)

            ranged_weapon = emitter.inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

            target_controller = target_info[:target]

            text = interpolate_me_others(emitter, target_controller, "You take aim at #{target_controller.short_desc}", "#{emitter.short_desc} takes aim at you", "#{emitter.short_desc} takes aim at #{target_controller.short_desc}")

            text << " with #{ranged_weapon.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
