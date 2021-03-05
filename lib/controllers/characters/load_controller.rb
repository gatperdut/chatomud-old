require "actions/unload"

module ChatoMud
  module Controllers
    module Characters
      class LoadController
        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
          @load_thread = nil
          @running = false
          @pre_finish = false
        end

        def start_load_thread(missile_controller, from)
          @missile_controller = missile_controller
          @running = true

          delay = 5
          # TODO: thread_load_controller needed?
          @load_thread = Thread.new(self, missile_controller, from, delay) do |thread_load_controller, thread_missile_controller, thread_from, thread_delay|
            sleep thread_delay
            @pre_finish = true
            Actions::FinishLoading.new(@server, @character_controller, { missile: thread_missile_controller, from: thread_from }).exec
          end
        end

        def is_loading?
          !!@running
        end

        def is_pre_finish?
          @pre_finish
        end

        def is_holding_load?
          loaded_ranged_weapon_controller = @character_controller.inventory_controller.ranged_weapon_controllers(:wielded, true)[0]

          loaded_ranged_weapon_controller ? !loaded_ranged_weapon_controller.weapon_stat_controller.ranged_stat_controller.can_remain_loaded? : false
        end

        def bye
          stop_loading
        end

        def stop_loading
          should_echo = is_loading?
          done_loading

          return unless should_echo

          @character_controller.room_controller.emit_action_echo("stop_loading", { emitter: @character_controller })
        end

        def stop_holding_load
          ChatoMud::Actions::Unload.new(@server, @character_controller, nil).exec if is_holding_load?
        end

        def done_loading
          @missile_controller = nil
          @running = false
          @pre_finish = false
          @load_thread&.terminate
        end
      end
    end
  end
end
