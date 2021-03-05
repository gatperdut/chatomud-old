require "mixins/characters/health/definition"

module ChatoMud
  module Mixins
    module Characters
      module Health
        include Mixins::Characters::Health::Definition

        module HasHits
          def max_hits
            50 + (stats_controller.skill_modifier(:body_development) / 2.0).round
          end

          def hits
            max_hits - @wound_controllers.map(&:damage).sum
          end

          def hits_percentage
            hits / max_hits.to_f
          end

          def has_max_hits?
            hits == max_hits
          end

          def heal
            return unless can_heal?

            return if has_max_hits?

            return unless update_hits_accruer

            num_wounds_healed = find_num_wounds_healed

            wound_controllers = autoheal_wounds.sample(num_wounds_healed)

            return if wound_controllers.nil?

            wound_controllers.each do |wound_controller|
              wound_controller.heal_by(find_num_hits_healed)
            end

            check_liveness
          end

          private

          def update_hits_accruer
            @recovery_accruer[:hits] = @recovery_accruer[:hits] + 1

            position = @character_controller.position_controller.position

            if @recovery_accruer[:hits] > hits_accrue_goal[position]
              @recovery_accruer[:hits] = 0
              return true
            end

            false
          end

          def can_heal?
            !@character_controller.combat_controller.is_in_combat?
          end

          def find_num_wounds_healed
            max = @character_controller.stats_controller.con_max_wounds_healed_per_pulse
            rand(1..max)
          end

          def find_num_hits_healed
            max = @character_controller.stats_controller.con_max_hits_healed_per_pulse
            rand(1..max)
          end
        end
      end
    end
  end
end
