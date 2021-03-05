require "mixins/body_parts/definition"

require "mixins/characters/combat/melee_target"
require "mixins/characters/combat/melee_assailant"
require "mixins/characters/combat/melee_damage_dealer"
require "mixins/characters/combat/ranged_damage_dealer"
require "mixins/characters/combat/melee_damage_taker"
require "mixins/characters/combat/ranged_damage_taker"
require "mixins/characters/combat/ranged_target"
require "mixins/characters/combat/fleer"

module ChatoMud
  module Controllers
    module Characters
      class CombatController
        attr_reader :character_controller
        attr_reader :target
        attr_reader :flee_direction

        extend Mixins::BodyParts::Definition

        include Mixins::Characters::Combat::MeleeTarget
        include Mixins::Characters::Combat::MeleeAssailant
        include Mixins::Characters::Combat::MeleeDamageDealer
        include Mixins::Characters::Combat::RangedDamageDealer
        include Mixins::Characters::Combat::MeleeDamageTaker
        include Mixins::Characters::Combat::RangedDamageTaker
        include Mixins::Characters::Combat::RangedTarget
        include Mixins::Characters::Combat::Fleer

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
          @combat_thread  = nil
          @switch_thread  = nil
          @flee_thread    = nil
          @flee_direction = nil
          @assailants = []
          @aimers = []
          @target = nil
        end

        def is_in_combat?
          is_attacking? || is_being_attacked?
        end

        def handle_flee_success
          @character_controller.walking_controller.flee(@flee_direction)
          @character_controller.group_controller.handle_fled
          stop_combat(false, true) if is_attacking?
          update_assailants(:fled)
          update_aimers(:fled, { direction: @flee_direction, fleeing: true })
          stop_fleeing(false) if is_fleeing?
        end

        def handle_death
          @character_controller.room_controller.emit_action_echo("die", { emitter: @character_controller })
          stop_combat(false, true) if is_attacking?
          stop_fleeing(false) if is_fleeing?
          update_assailants(:dead)
          update_aimers(:dead, { direction: nil, fleeing: false })
        end

        def handle_unconsciousness
          @character_controller.room_controller.emit_action_echo("fall_unconscious", { emitter: @character_controller })
          stop_combat(false, true) if is_attacking?
          stop_fleeing(false) if is_fleeing?
          update_assailants(:unconscious)
          update_aimers(:unconscious, { direction: nil, fleeing: false })
        end

        private

        def entity_controller
          @character_controller.entity_controller
        end

        def health_controller
          @character_controller.health_controller
        end

        def inventory_controller
          @character_controller.inventory_controller
        end

        def stats_controller
          @character_controller.stats_controller
        end

        def encumbrance_controller
          @character_controller.encumbrance_controller
        end

        def choice_controller
          @character_controller.choice_controller
        end

        def room_controller
          @character_controller.room_controller
        end

        def attack_referrer
          @server.attack_referrer
        end
      end
    end
  end
end
