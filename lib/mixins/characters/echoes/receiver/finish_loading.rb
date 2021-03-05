module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_finish_loading(params)
            emitter       = params[:emitter]
            missile       = params[:missile]

            ranged_weapon = emitter.inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

            text = interpolate_me_other(emitter, "You finish loading ", "#{emitter.short_desc} finishes loading ")

            text << "#{ranged_weapon.short_desc} with #{missile.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
