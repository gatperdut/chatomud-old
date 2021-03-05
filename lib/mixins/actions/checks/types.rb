module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Types
          def check_is_weapon(item_controller, message = nil)
            unless item_controller.is_weapon?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_melee_weapon(item_controller, message = nil)
            return false unless check_is_weapon(item_controller, message)

            unless item_controller.weapon_stat_controller.is_melee?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_ranged_weapon(item_controller, message = nil)
            unless item_controller.weapon_stat_controller.is_ranged?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_not_ranged_weapon(item_controller, message = nil)
            if item_controller.weapon_stat_controller.is_ranged?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_container(item_controller, message = nil)
            unless item_controller.is_container?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_stackable(item_controller, message = nil)
            unless item_controller.is_stackable?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_light_source(item_controller, message = nil)
            unless item_controller.is_light_source?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_fillable(item_controller, message = nil)
            unless item_controller.is_fillable?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_edible(item_controller, message = nil)
            unless item_controller.is_edible?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_missile(item_controller, message = nil)
            unless item_controller.is_missile?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_book(item_controller, message = nil)
            unless item_controller.is_book?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_board(item_controller, message = nil)
            unless item_controller.is_board?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_writing(item_controller, message = nil)
            unless item_controller.is_writing?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_writing_implement(item_controller, message = nil)
            unless item_controller.is_writing_implement?
              tx(message) if message
              return false
            end
            true
          end

          def check_is_ink_source(item_controller, message = nil)
            unless item_controller.is_ink_source?
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
