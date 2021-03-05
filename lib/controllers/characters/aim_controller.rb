require "mixins/directions/utils"
require "mixins/characters/combat/aim_holder"

module ChatoMud
  module Controllers
    module Characters
      class AimController
        include Mixins::Directions::Utils
        include Mixins::Characters::Combat::AimHolder

        attr_reader :target_info
        attr_reader :aim_stage

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
          @aim_thread = nil
          @target_info = nil
          @running = false
          @aim_stage = :not_aiming
        end

        def start_aim_thread(target_info)
          @target_info = target_info
          @running = true
          @aim_stage = :low
          @target_info[:target].combat_controller.add_aimer(@character_controller)

          delay = 2

          @aim_thread = Thread.new(target_info, delay) do |thread_target_info, thread_delay|
            sleep thread_delay
            @aim_stage = :medium
            sleep thread_delay
            @aim_stage = :high
            sleep thread_delay
            @aim_stage = :aimed
            Actions::FinishAiming.new(@server, @character_controller, {}).exec
          end
        end

        def is_aiming?
          !!@running
        end

        def bye
          cease_aiming
        end

        def fire
          target_controller = @target_info[:target]

          missile_controller = @character_controller.inventory_controller.ranged_weapon_controllers(:wielded, true)[0].weapon_stat_controller.ranged_stat_controller.inventory_controller.loaded_missile_controller

          direction = @target_info[:direction]

          line_of_sight = nil

          if direction
            direction = direction.to_sym
            line_of_sight = @character_controller.room_controller.line_of_sight(direction, @target_info[:distance])
          end

          @character_controller.combat_controller.perform_ranged_attack(target_controller, missile_controller, line_of_sight, direction)
        end

        def cease_aiming
          return unless @running

          done_aiming
          @character_controller.room_controller.emit_action_echo("cease_aiming", { emitter: @character_controller, reason: :none })
        end

        def done_aiming
          @target_info[:target].combat_controller.remove_aimer(@character_controller)
          @target_info = nil
          @running = false
          @aim_thread.terminate
          @aim_stage = :not_aiming
        end
      end
    end
  end
end
