require "mixins/random/utils"

module ChatoMud
  module Mixins
    module Characters
      module Combat
        module MeleeTarget
          include Mixins::Random::Utils

          def can_be_attacked?
            !@character_controller.walking_controller.is_walking?
          end

          def is_being_attacked?
            @assailants.present?
          end

          def list_assailants
            @assailants.map(&:short_desc).to_sentence
          end

          def non_target_assailants
            @assailants - [@target]
          end

          def handle_fight_back(opponent_controller)
            @character_controller.load_controller.stop_loading
            @character_controller.load_controller.stop_holding_load

            add_assailant(opponent_controller)

            return if @character_controller.health_controller.is_unconscious? || is_attacking? || choice_controller.stance_is?(:pacifist)

            target!(opponent_controller)
            start_combat_thread
            @character_controller.aasm_controller.aasm_handle.attack(nil) if @character_controller.is_npc?
            opponent_controller.combat_controller.add_assailant(@character_controller)
          end

          def add_assailant(assailant_controller)
            @assailants << assailant_controller
          end

          def remove_assailant(assailant_controller)
            @assailants.delete(assailant_controller)
          end

          def melee_deflect_mode
            return :block if d100(:closed) < 75 && @character_controller.inventory_controller.using_shield?

            return :parry if d100(:closed) < 75 && @character_controller.inventory_controller.wielding_melee_weapon?

            :dodge
          end

          def update_assailants(reason)
            assailants_copy = @assailants.map(&:clone)

            assailants_copy.each do |assailant|
              assailant.combat_controller.send("handle_#{reason}_opponent")
            end
          end
        end
      end
    end
  end
end
