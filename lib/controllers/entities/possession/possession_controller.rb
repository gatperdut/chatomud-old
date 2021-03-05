require "mixins/characters/physical_attrs/genders/utils"

module ChatoMud
  module Controllers
    module Entities
      class PossessionController
        attr_reader :possessed_controller
        attr_reader :possessing_controller
        attr_reader :quietly

        include Mixins::Characters::PhysicalAttrs::Genders::Utils

        def initialize(server, entity_controller)
          @server                = server
          @entity_controller     = entity_controller
          @possessed_controller  = nil
          @possessing_controller = nil
          @quietly               = "hola"
        end

        def is_possessing?
          !!@possessed_controller
        end

        def is_possessed?
          !!@possessing_controller
        end

        def possess(possessed_controller, quietly)
          @possessed_controller = possessed_controller
          @quietly = quietly
          if quietly
            @entity_controller.tx("You slip, unnoticed, into the mind of #{possessed_controller.character_controller.short_desc}.", true)
          else
            @entity_controller.tx("You take command of #{possessed_controller.character_controller.short_desc}.", true)
          end
          @possessed_controller.possession_controller.be_possessed(@entity_controller, quietly)
        end

        def be_possessed(possessing_controller, quietly)
          @quietly = quietly
          @entity_controller.tx("You feel a force taking over you ...") unless quietly
          @possessing_controller = possessing_controller

          @entity_controller.character_controller.aasm_controller.aasm_handle.be_possessed if @entity_controller.is_bot?
        end

        def release(reason)
          character_controller = @possessed_controller.character_controller
          @possessed_controller = nil
          case reason
            when :possesser_death
              @entity_controller.tx("You leave the mind of #{character_controller.short_desc} as your own body dies ...", true)
            when :vessel_death
              @entity_controller.tx("#{character_controller.short_desc} has died, you leave #{possessive(character_controller.physical_attr_controller.gender)} mind.", true)
            when :possesser_disconnection
            when :vessel_disconnection
              @entity_controller.tx("Your prey is gone.")
            when :released
              @entity_controller.tx("You abandon the mind of #{character_controller.short_desc}.", true)
            else
              raise "Unknown reason for possession release '#{reason}'."
          end
        end

        def be_released(reason)
          @possessing_controller.possession_controller.release(reason)
          @possessing_controller = nil
          unless @quietly
            case reason
              when :possesser_death
                @entity_controller.tx("You feel the presence vanish abruptly from your mind.")
              when :vessel_death
                @entity_controller.tx("The presence leaves your mind as you die.")
              when :possesser_disconnection
                @entity_controller.tx("You feel the presence go far, far away.")
              when :released
                @entity_controller.tx("You feel the presence leaving your mind.")
              else
                raise "Unknown reason for possession be_released '#{reason}'."
            end
          end

          @entity_controller.character_controller.aasm_controller.aasm_handle.be_released if @entity_controller.is_bot?
        end

        def handle_disconnection_when_possessing
          return unless is_possessing?

          @possessed_controller.possession_controller.be_released(:possesser_disconnection)
          @possessed_controller = nil
        end

        def handle_disconnection_when_possessed
          return unless is_possessed?

          @possessing_controller.possession_controller.release(:vessel_disconnection)
          @possessing_controller = nil
        end

        def handle_death_when_possessing
          return unless is_possessing?

          @possessed_controller.possession_controller.be_released(:possesser_death)
        end

        def handle_death_when_possessed
          return unless is_possessed?

          be_released(:vessel_death)
        end
      end
    end
  end
end
