require "controllers/characters/health/wound_controller"

require "mixins/characters/health/has_hits"
require "mixins/characters/health/has_exhaustion"
require "mixins/characters/health/liveness"
require "mixins/characters/health/wound_manager"

require "mixins/damage/utils"

module ChatoMud
  module Controllers
    module Characters
      module Health
        class HealthController
          include Mixins::Damage::Utils
          include Mixins::Characters::Health::HasHits
          include Mixins::Characters::Health::HasExhaustion
          include Mixins::Characters::Health::Liveness
          include Mixins::Characters::Health::WoundManager

          def initialize(server, character_controller, health)
            @server = server
            @character_controller = character_controller
            @health = health

            @wound_controllers = []
            health.wounds.each do |wound|
              WoundController.new(@server, self, wound)
            end

            @conscious = hits > unconsciousness_hits

            @recovery_accruer = {
              hits:              0,
              exhaustion: 0
            }
          end

          def suffer_melee_attack(attack, body_part)
            damage_type = regular_damage_type_for(attack.base.to_sym)

            wound = @health.wounds.create!(damage: attack[:hits], body_part: body_part, damage_type: damage_type, inventory: nil)

            WoundController.new(@server, self, wound)
          end

          def suffer_ranged_attack(attack, missile_controller, body_part)
            damage_type = regular_damage_type_for(attack.base.to_sym)

            wound = @health.wounds.create!(damage: attack.hits, body_part: body_part, damage_type: damage_type, inventory: Inventory.new)

            wound_controller = WoundController.new(@server, self, wound)

            wound_controller.inventory_controller.accept_item(missile_controller, true)
          end

          private

          def stats_controller
            @character_controller.stats_controller
          end

          def attribute_bonus_referrer
            @server.attribute_bonus_referrer
          end
        end
      end
    end
  end
end
