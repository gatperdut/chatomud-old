require "mixins/describable/common"
require "mixins/characters/physical_attrs/genders/utils"

module ChatoMud
  module Mixins
    module Describable
      module Character
        include Common
        include Characters::PhysicalAttrs::Genders::Utils

        def short_desc
          if @visibility_controller.is_visible?
            return model.short_desc.magenta
          end

          "someone".magenta
        end

        def long_desc
          text =
            if @combat_controller.is_attacking?
              short_desc + " is here, fighting " + @combat_controller.target.short_desc + "."
            elsif !health_controller.is_conscious?
              short_desc + " is lying here, unconscious."
            elsif @position_controller.is_resting?
              if @position_controller.is_accommodated?
                short_desc + " is resting at #{@position_controller.furniture_controller.short_desc}."
              else
                short_desc + " is here, resting on the ground."
              end
            elsif @position_controller.is_sitting?
              if @position_controller.is_accommodated?
                short_desc + " is sitting at #{@position_controller.furniture_controller.short_desc}."
              else
                short_desc + " is here, sitting on the ground."
              end
            elsif @load_controller.is_loading?
              short_desc + " is here, loading #{@inventory_controller.ranged_weapon_controllers(:wielded, false)[0].short_desc}"
            elsif @load_controller.is_holding_load?
              short_desc + " is here, holding #{@inventory_controller.ranged_weapon_controllers(:wielded, true)[0].short_desc} loaded."
            elsif @aim_controller.is_aiming?
              ranged_weapon_controller = @inventory_controller.ranged_weapon_controllers(:wielded, true)[0]
              direction = @aim_controller.target_info[:direction]
              if direction
                short_desc + " is here, aiming #{@aim_controller.target_info[:direction]}ward with #{ranged_weapon_controller.short_desc} ."
              else
                target_controller = @aim_controller.target_info[:target]
                short_desc + " is here, aiming at #{target_controller.short_desc} with #{ranged_weapon_controller.short_desc} ."
              end
            else
              model.long_desc.magenta
            end

          text << link_dead_flag

          text << aasm_state_flag

          text << editing_flag
        end

        def full_desc(gender)
          text =  "\n#{short_desc}\n\n"
          text << "#{model.full_desc}\n\n"
          text << "#{height_and_weight(gender)}\n"
          text << "#{list_inventory(gender)}"
          text << "#{list_wounds(gender)}"
          text
        end

        def height_and_weight(gender)
          if gender == :personal
            height = @physical_attr_controller.height
            weight = @physical_attr_controller.weight
            about = " "
          else
            height = @physical_attr_controller.height_approximation
            weight = @physical_attr_controller.weight_approximation
            about = " about "
          end

          "#{personal(gender)} #{to_be(gender)}#{about}#{height} centimeters tall and #{weight} kilograms in weight."
        end

        def link_dead_flag
          @entity_controller.is_waiting_for_reconnection? ? " <link dead>".red : ""
        end

        def aasm_state_flag
          @entity_controller.is_bot? ? "<#{@aasm_controller.aasm_handle.aasm_read_state}>" : ""
        end

        def editing_flag
          @entity_controller.is_editing? ? " <editing>".red : ""
        end
      end
    end
  end
end
