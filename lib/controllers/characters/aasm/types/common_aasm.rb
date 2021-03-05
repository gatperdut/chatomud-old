module ChatoMud
  module Controllers
    module Characters
      module Aasm
        module Types
          class CommonAasm
            include AASM

            def initialize(server, aasm_controller)
              @server          = server
              @aasm_controller = aasm_controller
              @clock_thread    = nil
            end

            aasm do
              state :running, initial: true

              state :attacking

              state :unconscious

              state :possessed

              state :calmed_down

              state :dead

              after_all_transitions :log_status_change

              event :attack do
                transitions from: [:running, :possessed, :calmed_down], to: :attacking, after: proc { |*args| handle_attack(*args) }
              end

              event :stop_attacking do
                transitions from: [:possessed], to: :possessed,   if: :is_possessed?
                transitions from: [:possessed], to: :attacking,   if: :is_in_combat?
                transitions from: [:attacking], to: :calmed_down, if: :is_inactive?
                transitions from: [:attacking], to: :running
              end

              event :regain_consciousness do
                transitions from: [:unconscious, :possessed, :calmed_down], to: :running,     after: :handle_regain_consciousness, if: :is_active?
                transitions from: [:unconscious, :possessed, :calmed_down], to: :calmed_down, after: :handle_regain_consciousness, if: :is_inactive?
              end

              event :fall_unconscious do
                transitions from: [:running, :attacking, :possessed, :calmed_down], to: :unconscious
              end

              event :be_possessed do
                transitions to: :possessed
              end

              event :be_released do
                transitions from: :possessed, to: :calmed_down, if: :is_inactive?
                transitions from: :possessed, to: :attacking,   if: :is_in_combat?
                transitions from: :possessed, to: :running,     if: :is_conscious?
                transitions from: :possessed, to: :unconscious
              end

              event :calmdown do
                transitions to: :calmed_down
              end

              event :activate do
                transitions from: [:calmed_down], to: :running
              end

              event :die do
                transitions to: :dead, after: proc { |*args| handle_death(*args) }
              end
            end

            def log_status_change
              from = aasm.from_state ? " from #{aasm.from_state}" : ""
              puts "#{character_controller.short_desc} changing#{from} to #{aasm.to_state} (event: #{aasm.current_event})"
            end

            def set_initial_state
              if is_unconscious?
                fall_unconscious
              elsif is_inactive?
                calmdown
              end
            end

            def start_clock_thread
              @clock_thread = Thread.new(self) do |aggro_aasm|
                sleep 5
                until aggro_aasm.dead?
                  aggro_aasm.do_action if aggro_aasm.running?
                  sleep 10
                end
              end
            end

            def handle_death
              @clock_thread.terminate
            end

            def handle_attack(target_controller)
              combat_controller.fight(target_controller, true) if target_controller
            end

            def do_action
              interpret("stand") if position_controller.is_sitting_or_resting?
            end

            def is_conscious?
              health_controller.is_conscious?
            end

            def is_unconscious?
              health_controller.is_unconscious?
            end

            def is_in_combat?
              combat_controller.is_in_combat?
            end

            def is_active?
              @aasm_controller.active?
            end

            def is_inactive?
              @aasm_controller.inactive?
            end

            def is_possessed?
              possession_controller.is_possessed?
            end

            def handle_regain_consciousness
            end

            def interpret(command)
              character_controller.interpret(command)
            end

            def position_controller
              character_controller.position_controller
            end

            def room_controller
              character_controller.room_controller
            end

            def combat_controller
              character_controller.combat_controller
            end

            def health_controller
              character_controller.health_controller
            end

            def possession_controller
              entity_controller.possession_controller
            end

            def entity_controller
              character_controller.entity_controller
            end

            def character_controller
              @aasm_controller.character_controller
            end
          end
        end
      end
    end
  end
end
