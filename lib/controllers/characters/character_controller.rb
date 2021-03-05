require "interpreter/interpreter"

require "controllers/base_controller"

require "controllers/characters/stats_controller"
require "controllers/characters/choice_controller"
require "controllers/characters/comms_controller"
require "controllers/characters/health/health_controller"
require "controllers/characters/position_controller"
require "controllers/characters/physical_attr_controller"
require "controllers/characters/encumbrance_controller"
require "controllers/characters/nourishment_controller"
require "controllers/characters/group_controller"
require "controllers/characters/combat_controller"
require "controllers/characters/load_controller"
require "controllers/characters/aim_controller"
require "controllers/characters/spasms_controller"
require "controllers/characters/walking_controller"
require "controllers/characters/visibility_controller"
require "controllers/crafts/crafts_controller"

require "controllers/inventories/character_inventory_controller"

require "mixins/characters/echoes/receiver/base"
require "mixins/characters/physical_attrs/genders/utils"
require "mixins/describable/character"
require "mixins/characters/gifts/gifted"
require "mixins/characters/searcher"
require "mixins/characters/searcher_itc"
require "mixins/characters/status/utils"

module ChatoMud
  module Controllers
    module Characters
      class CharacterController < BaseController
        attr_reader :inventory_controller
        attr_reader :walking_controller
        attr_reader :stats_controller
        attr_reader :choice_controller
        attr_reader :comms_controller
        attr_reader :health_controller
        attr_reader :position_controller
        attr_reader :physical_attr_controller
        attr_reader :encumbrance_controller
        attr_reader :nourishment_controller
        attr_reader :group_controller
        attr_reader :combat_controller
        attr_reader :load_controller
        attr_reader :aim_controller
        attr_reader :spasms_controller
        attr_reader :visibility_controller
        attr_reader :crafts_controller

        attr_accessor :entity_controller

        include Mixins::Characters::PhysicalAttrs::Genders::Utils
        include Mixins::Characters::Gifts::Gifted
        include Mixins::Characters::Searcher
        include Mixins::Characters::SearcherItc
        include Mixins::Characters::Echoes::Receiver
        include Mixins::Characters::Status::Utils
        include Mixins::Describable::Character

        attr_reader :room_controller

        def initialize(server, entity_controller, character, room_controller)
          super(server)
          @entity_controller = entity_controller
          @character         = character

          room_controller.accept_character(self, false)

          @interpreter = Grammar::Interpreter.new(@server, self)

          @inventory_controller     = Inventories::CharacterInventoryController.new(@server, self, @character.inventory)
          @walking_controller       = WalkingController.new(@server, self)
          @stats_controller         = StatsController.new(@server, self, @character.attribute_set, @character.skill_set)
          @choice_controller        = ChoiceController.new(@server, @character.choice)
          @health_controller        = Health::HealthController.new(@server, self, @character.health)
          @position_controller      = PositionController.new(@server, self)
          @physical_attr_controller = PhysicalAttrController.new(@server, self, @character.physical_attr)
          @encumbrance_controller   = EncumbranceController.new(@server, self)
          @nourishment_controller   = NourishmentController.new(@server, self, @character.nourishment)
          @comms_controller         = CommsController.new(@server, self)
          @group_controller         = GroupController.new(@server, self)
          @combat_controller        = CombatController.new(@server, self)
          @load_controller          = LoadController.new(@server, self)
          @aim_controller           = AimController.new(@server, self)
          @spasms_controller        = SpasmsController.new(@server, self)
          @visibility_controller    = VisibilityController.new(@server, self)
          @crafts_controller        = Crafts::CraftsController.new(@server, self)

          @server.characters_handler.add_character_controller(self)
        end

        def reload_model
          @character = Character.find(@character.id)
          @stats_controller.reload_model
        end

        def bye
          emit_leave_area

          @group_controller.handle_quit

          @combat_controller.update_aimers(:quit, { direction: nil, fleeing: false })

          @server.characters_handler.remove_character_controller(self)
          @room_controller.remove_character_controller(self)

          handle_controllers_death_and_quit
        end

        def teleport(disband_group)
          group_controller.handle_teleport if disband_group

          @position_controller.stand

          @combat_controller.stop_combat(false, true)
          @combat_controller.update_assailants(:gone)
          @combat_controller.stop_fleeing(false)

          @aim_controller.cease_aiming
          @combat_controller.update_aimers(:gone, { direction: nil, fleeing: false })
        end

        def die
          @entity_controller.possession_controller.handle_death_when_possessing
          @entity_controller.possession_controller.handle_death_when_possessed

          @group_controller.handle_death

          @spasms_controller.drop_carried_items if @inventory_controller.is_carrying_anything?
          @position_controller.rest
          @position_controller.abandon_place if @position_controller.is_accommodated?

          produce_corpse

          @server.characters_handler.remove_character_controller(self)
          @room_controller.remove_character_controller(self)
          @entity_controller.handle_character_death

          @character.update(active: false) if is_pc?
          @character.destroy if is_npc?

          @server.arena_master.replenish if @character.gladiator

          @aasm_controller.aasm_handle.die if is_npc?

          handle_controllers_death_and_quit
          @combat_controller.handle_death
        end

        def fall_unconscious
          @position_controller.abandon_place if @position_controller.is_accommodated?
          @position_controller.rest
          @spasms_controller.drop_carried_items if @inventory_controller.is_carrying_anything?

          @aasm_controller.aasm_handle.fall_unconscious if is_npc?

          handle_controllers_unconsciousness
          @combat_controller.handle_unconsciousness
        end

        def regain_consciousness
          @aasm_controller.aasm_handle.regain_consciousness if is_npc?

          @room_controller.emit_action_echo("regain_consciousness", { emitter: self })
        end

        def produce_corpse
          corpse_controller = @server.items_spawner.spawn_corpse(self)
          @inventory_controller.dump_items_into(corpse_controller)
        end

        def appear_in(new_room_controller, room, remove_from_containing_room)
          @room_controller.remove_character_controller(self) if remove_from_containing_room
          new_room_controller.add_character_controller(self)
          @room_controller = new_room_controller
          @character.room = room
          @character.save!
        end

        def calmdown
          tx("You are forced to calm down!")
          @combat_controller.stop_combat(false, true)
        end

        def name
          @character.name
        end

        def can_walk?
          @position_controller.is_standing? && @health_controller.is_conscious? && @walking_controller.has_enough_exhaustion?
        end

        def interpret(command, redirect_to = nil)
          @interpreter.exec(command, redirect_to)
        end

        def tx(message, vessel = false)
          @entity_controller&.tx(message, vessel) # npc being instantiated e.g.
        end

        # TODO: move these guys to the echoes?
        def emit_enter_area
          @room_controller.emit_echo(self, "#{short_desc} enters the area.")
        end

        def emit_leave_area
          @room_controller.emit_echo(self, "#{short_desc} leaves the area.")
        end

        def emit_disconnection
          @room_controller.emit_echo(self, "#{short_desc} has lost connection.")
        end

        def emit_reconnection
          @room_controller.emit_echo(self, "#{short_desc} has reconnected.")
        end
        # TODO: /move these guys to the echoes.

        def show_room
          @room_controller.show(self)
        end

        def list_wounds(gender)
          text = @health_controller.list_wounds(gender)
          if text.present?
            "\n#{personal(gender)} #{to_have(gender)} suffered #{text}.\n"
          else
            "\n#{personal(gender)} #{to_be(gender)} in perfect condition.\n"
          end
        end

        def list_inventory(gender)
          text = @inventory_controller.list_inventory(gender)
          if text.present?
            "#{personal(gender)} #{to_be(gender)} carrying:\n#{text}"
          else
            "#{personal(gender)} #{to_be(gender)} naked."
          end
        end

        def model
          @character
        end

        def id
          @character.id
        end

        def is?(character)
          id == character.id
        end

        private

        def handle_controllers_common
          @walking_controller.bye
          @load_controller.bye
          @aim_controller.bye
        end

        def handle_controllers_death_and_quit
          handle_controllers_common
          @inventory_controller.bye
        end

        def handle_controllers_unconsciousness
          handle_controllers_common
        end
      end
    end
  end
end
