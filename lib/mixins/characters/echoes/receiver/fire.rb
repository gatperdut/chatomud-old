module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_fire(params)
            emitter = params[:emitter]
            target  = params[:target]

            direction = emitter.aim_controller.target_info[:direction]

            ranged_weapon_controller = emitter.inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

            ranged_stat_controller = ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller

            missile_controller = ranged_stat_controller.inventory_controller.loaded_missile_controller

            can_remain_loaded = ranged_stat_controller.can_remain_loaded?

            text_self = can_remain_loaded ? "You pull the trigger of" : "You release the string of"

            text_others = can_remain_loaded ? "#{emitter.short_desc} pulls the trigger of" : "#{emitter.short_desc} releases the string of"

            direction_string = direction ?  " #{direction}ward" : ""

            common = " #{ranged_weapon_controller.short_desc}, launching #{missile_controller.short_desc}#{direction_string} toward #{target.short_desc}."

            text_self << common

            text_others << common

            text = interpolate_me_other(emitter, text_self, text_others)

            tx(text)
          end
        end
      end
    end
  end
end
