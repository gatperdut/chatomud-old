module ChatoMud
  module Mixins
    module Characters
      module Combat
        module RangedTarget
          def is_being_aimed_at?
            @aimers.present?
          end

          def list_aimers
            @aimers.map(&:short_desc).to_sentence
          end

          def add_aimer(aimer_controller)
            @aimers << aimer_controller
          end

          def remove_aimer(aimer_controller)
            @aimers.delete(aimer_controller)
          end

          def update_aimers(reason, data)
            @aimers.each do |aimer|
              aimer.aim_controller.update_aim(reason, data)
            end
          end

          def ranged_deflect_mode
            return :block if d100(:closed) < 90 && @character_controller.inventory_controller.using_shield?

            return :parry if d100(:closed) < 5 && @character_controller.inventory_controller.wielding_melee_weapon?

            :dodge
          end
        end
      end
    end
  end
end
