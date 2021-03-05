module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_load(params)
            emitter       = params[:emitter]
            missile       = params[:missile]
            from          = params[:from]

            ranged_weapon = emitter.inventory_controller.ranged_weapon_controllers(:wielded, false)[0]

            case from
              when :from_hand
                from_string = ""
              when :from_quiver
                from_string = " from #{missile.containing_inventory_controller.owner_controller.short_desc}"
            end

            text = interpolate_me_other(emitter, "You start loading ", "#{emitter.short_desc} starts loading ")

            text << "#{ranged_weapon.short_desc} with #{missile.short_desc}#{from_string}."

            tx(text)
          end
        end
      end
    end
  end
end
