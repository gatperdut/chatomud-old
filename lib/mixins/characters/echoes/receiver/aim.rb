module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_aim(params)
            emitter       = params[:emitter]
            target_info   = params[:target_info]

            return unless can_see_action?(emitter)

            ranged_weapon = emitter.inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

            text = interpolate_me_other(emitter, "You take aim #{target_info[:direction]}ward at #{target_info[:target].short_desc}", "#{emitter.short_desc} takes aim #{target_info[:direction]}ward")

            text << " with #{ranged_weapon.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
