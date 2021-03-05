module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Weapons
          def check_missile_type_is(missile_controller, missile_type, message = nil)
            unless missile_controller.missile_stat_controller.is_missile_type?(missile_type)
              tx(message) if message
              return false
            end
            true
          end

          def check_can_load_or_unload(ranged_weapon_controller, missile_controller, message = nil)
            return true if ranged_weapon_controller.is_in_slot?(:w2hands)

            unless @character_controller.inventory_controller.can_hold?(missile_controller)
              tx(message) if message
              return false
            end
            true
          end

          def check_is_not_loaded(ranged_weapon_controller, message = nil)
            if ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_loaded(ranged_weapon_controller, message = nil)
            unless ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_loading(character_controller, message)
            unless character_controller.load_controller.is_loading?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_not_loading(character_controller, message)
            if character_controller.load_controller.is_loading?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_aiming(character_controller, message)
            unless character_controller.aim_controller.is_aiming?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_not_aiming(character_controller, message)
            if character_controller.aim_controller.is_aiming?
              tx(message) if message
              return false
            end
            true
          end

          def check_can_wield(weapon_controller)
            unless @character_controller.inventory_controller.can_wield?(weapon_controller)
              tx("You will need #{weapon_controller.weapon_stat_controller.hands_requirement} to wield #{weapon_controller.short_desc}.")
              return false
            end
            true
          end

          def check_is_wielded(target_controller, message)
            unless target_controller.is_wielded?
              tx(message) if message
              return false
            end
            true
          end
        end
      end
    end
  end
end
