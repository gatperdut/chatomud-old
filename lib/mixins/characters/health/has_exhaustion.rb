require "mixins/characters/health/definition"

module ChatoMud
  module Mixins
    module Characters
      module Health
        module HasExhaustion
          include Mixins::Characters::Health::Definition

          def max_exhaustion
            @character_controller.stats_controller.attribute_value(:con)
          end

          def exhaustion
            @health.exhaustion
          end

          def exhaustion_percentage
            exhaustion / max_exhaustion.to_f
          end

          def has_max_exhaustion?
            exhaustion == max_exhaustion
          end

          def can_consume_exhaustion?(amount)
            @health.exhaustion >= amount
          end

          def consume_exhaustion(amount)
            @health.exhaustion = @health.exhaustion - amount

            @health.exhaustion = @health.exhaustion.clamp(0, max_exhaustion)

            @health.save!
          end

          def replenish_exhaustion(amount)
            @health.exhaustion = @health.exhaustion + amount

            @health.exhaustion = @health.exhaustion.clamp(0, max_exhaustion)

            @health.save!
          end

          def catch_breath
            return unless can_catch_breath?

            return if has_max_exhaustion?

            return unless update_exhaustion_accruer

            exhaustion_recovered = exhaustion_recovery[@character_controller.position_controller.position]

            replenish_exhaustion(exhaustion_recovered)
          end

          def exhaustion_penalty
            case exhaustion_percentage
              when 0.00..0.25
                32
              when 0.25..0.50
                16
              when 0.50..0.75
                8
              when 0.75..0.90
                4
              when 0.90..1.00
                0
              else
                raise "Invalid exhaustion percentage when determining exhaustion penalty."
            end
          end

          private

          def update_exhaustion_accruer
            @recovery_accruer[:exhaustion] = @recovery_accruer[:exhaustion] + 1

            position = @character_controller.position_controller.position

            if @recovery_accruer[:exhaustion] >= exhaustion_accrue_goal[position]
              @recovery_accruer[:exhaustion] = 0
              return true
            end

            false
          end

          def can_catch_breath?
            !@character_controller.combat_controller.is_attacking?
          end
        end
      end
    end
  end
end
