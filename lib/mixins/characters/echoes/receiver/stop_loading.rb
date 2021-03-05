module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_stop_loading(params)
            emitter = params[:emitter]

            return unless can_see_action?(emitter)

            ranged_weapon = emitter.inventory_controller.ranged_weapon_controllers(:wielded, false)[0]

            text = interpolate_me_other(emitter, "You cease loading ", "#{emitter.short_desc} ceases loading ")

            text << "#{ranged_weapon.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
