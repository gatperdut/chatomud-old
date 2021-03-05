require "require_all"

require "socket"

require "handlers/superareas_handler"
require "handlers/areas_handler"
require "handlers/rooms_handler"
require "handlers/items_handler"
require "handlers/furnitures_handler"
require "handlers/doors_handler"
require "handlers/entities_handler"
require "handlers/characters_handler"

require "spawners/characters_spawner"
require "spawners/items_spawner"

require "spawners/factories/characters_factory"
require "spawners/factories/nourishments_factory"
require "spawners/factories/skill_sets_factory"
require "spawners/factories/physical_attrs_factory"
require "spawners/factories/attribute_sets_factory"
require "spawners/factories/choices_factory"
require "spawners/factories/basic_attributes_factory"
require "spawners/factories/healths_factory"
require "spawners/factories/amounts_factory"
require "spawners/factories/amount_data_factory"
require "spawners/factories/items_factory"
require "spawners/factories/horn_properties_factory"
require "spawners/factories/weapon_stats_factory"
require "spawners/factories/melee_stats_factory"
require "spawners/factories/ranged_stats_factory"
require "spawners/factories/missile_stats_factory"
require "spawners/factories/armor_stats_factory"
require "spawners/factories/shield_stats_factory"
require "spawners/factories/light_sources_factory"
require "spawners/factories/solid_fuel_reqs_factory"
require "spawners/factories/liquid_fuel_reqs_factory"
require "spawners/factories/inventories_factory"
require "spawners/factories/lids_factory"
require "spawners/factories/locks_factory"
require "spawners/factories/writing_implements_factory"
require "spawners/factories/books_factory"
require "spawners/factories/ink_sources_factory"

require "spawners/outfitters/characters_outfitter"
require "spawners/outfitters/items_outfitter"

require "referrers/attribute_bonus_referrer"
require "referrers/category_rank_referrer"
require "referrers/rank_referrer"
require "referrers/skill_category_referrer"
require "referrers/skill_referrer"
require "referrers/protection_referrer"
require "referrers/attack_referrer"
require "referrers/base_frame_referrer"
require "referrers/frame_modifier_referrer"

require "arena/arena_master"

require "periodic/timer"

require "cm_socket"

module ChatoMud
  class Server
    # TODO: group handlers, spawners, factories, outfitters & referrers separately under
    # handlers_assistant, spawners_assistant, etc.
    attr_reader :superareas_handler
    attr_reader :areas_handler
    attr_reader :rooms_handler
    attr_reader :items_handler
    attr_reader :furnitures_handler
    attr_reader :doors_handler
    attr_reader :entities_handler
    attr_reader :characters_handler

    attr_reader :characters_spawner
    attr_reader :items_spawner

    attr_reader :characters_factory
    attr_reader :nourishments_factory
    attr_reader :attribute_sets_factory
    attr_reader :choices_factory
    attr_reader :skill_sets_factory
    attr_reader :physical_attrs_factory
    attr_reader :basic_attributes_factory
    attr_reader :healths_factory
    attr_reader :amounts_factory
    attr_reader :amount_data_factory
    attr_reader :items_factory
    attr_reader :horn_properties_factory
    attr_reader :weapon_stats_factory
    attr_reader :melee_stats_factory
    attr_reader :ranged_stats_factory
    attr_reader :missile_stats_factory
    attr_reader :armor_stats_factory
    attr_reader :shield_stats_factory
    attr_reader :light_sources_factory
    attr_reader :solid_fuel_reqs_factory
    attr_reader :liquid_fuel_reqs_factory
    attr_reader :inventories_factory
    attr_reader :lids_factory
    attr_reader :locks_factory
    attr_reader :writing_implements_factory
    attr_reader :books_factory
    attr_reader :ink_sources_factory

    attr_reader :characters_outfitter
    attr_reader :items_outfitter

    attr_reader :attribute_bonus_referrer
    attr_reader :category_rank_referrer
    attr_reader :rank_referrer
    attr_reader :skill_category_referrer
    attr_reader :skill_referrer
    attr_reader :protection_referrer
    attr_reader :attack_referrer
    attr_reader :base_frame_referrer
    attr_reader :frame_modifier_referrer

    attr_reader :timer

    attr_reader :arena_master

    def initialize
      Rails.logger.info("ChatoMud listening port 1234.")
      Rails.logger.info("Environment: #{Rails.env}".red)
      @tcp_server = TCPServer.new(1234)
      initialize_referrers
      initialize_handlers
      initialize_spawners
      initialize_factories
      initialize_outfitters
      initialize_timer
      initialize_arena
    end

    def listen
      Rails.logger.info("ChatoMud listening now port 1234.")
      loop do
        begin
          player_socket = @tcp_server.accept.extend CMSocket
          # TODO: Would likely need to check these values... overkill?
          player_socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true)
          player_socket.setsockopt(Socket::SOL_TCP, Socket::TCP_KEEPIDLE, 2)
          player_socket.setsockopt(Socket::SOL_TCP, Socket::TCP_KEEPINTVL, 2)
          player_socket.setsockopt(Socket::SOL_TCP, Socket::TCP_KEEPCNT, 2)
        rescue IOError
          Rails.logger.info("ChatoMud server stopped listening.")
          return
        end
        @entities_handler.add_player_controller(player_socket)
      end
    end

    def bye
      terminate_handlers
      terminate_timer
      @tcp_server.close
      Rails.logger.info("ChatoMud server shutdown.")
      Thread.current.terminate
    end

    private

    def initialize_handlers
      Rails.logger.info("Instantiating handlers.")
      @superareas_handler = Handlers::SuperareasHandler.new(self)
      @areas_handler      = Handlers::AreasHandler.new(self)
      @rooms_handler      = Handlers::RoomsHandler.new(self)
      @items_handler      = Handlers::ItemsHandler.new(self)
      @furnitures_handler = Handlers::FurnituresHandler.new(self)
      @doors_handler      = Handlers::DoorsHandler.new(self)
      @entities_handler   = Handlers::EntitiesHandler.new(self)
      @characters_handler = Handlers::CharactersHandler.new(self)

      @superareas_handler.load_superareas
      @areas_handler.load_areas
      @rooms_handler.load_rooms
      @doors_handler.load_doors

      @entities_handler.load_bots
    end

    def initialize_spawners
      Rails.logger.info("Initializing spawners.")
      @characters_spawner = Spawners::CharactersSpawner.new(self)
      @items_spawner      = Spawners::ItemsSpawner.new(self)
    end

    def initialize_factories
      Rails.logger.info("Initializing factories.")
      @characters_factory         = Spawners::Factories::CharactersFactory.new(self)
      @nourishments_factory       = Spawners::Factories::NourishmentsFactory.new(self)
      @attribute_sets_factory     = Spawners::Factories::AttributeSetsFactory.new(self)
      @choices_factory            = Spawners::Factories::ChoicesFactory.new(self)
      @skill_sets_factory         = Spawners::Factories::SkillSetsFactory.new(self)
      @physical_attrs_factory     = Spawners::Factories::PhysicalAttrsFactory.new(self)
      @basic_attributes_factory   = Spawners::Factories::BasicAttributesFactory.new(self)
      @healths_factory            = Spawners::Factories::HealthsFactory.new(self)
      @amounts_factory            = Spawners::Factories::AmountsFactory.new(self)
      @amount_data_factory        = Spawners::Factories::AmountDataFactory.new(self)
      @items_factory              = Spawners::Factories::ItemsFactory.new(self)
      @horn_properties_factory    = Spawners::Factories::HornPropertiesFactory.new(self)
      @weapon_stats_factory       = Spawners::Factories::WeaponStatsFactory.new(self)
      @melee_stats_factory        = Spawners::Factories::MeleeStatsFactory.new(self)
      @ranged_stats_factory       = Spawners::Factories::RangedStatsFactory.new(self)
      @missile_stats_factory      = Spawners::Factories::MissileStatsFactory.new(self)
      @armor_stats_factory        = Spawners::Factories::ArmorStatsFactory.new(self)
      @shield_stats_factory       = Spawners::Factories::ShieldStatsFactory.new(self)
      @light_sources_factory      = Spawners::Factories::LightSourcesFactory.new(self)
      @solid_fuel_reqs_factory    = Spawners::Factories::SolidFuelReqsFactory.new(self)
      @liquid_fuel_reqs_factory   = Spawners::Factories::LiquidFuelReqsFactory.new(self)
      @inventories_factory        = Spawners::Factories::InventoriesFactory.new(self)
      @lids_factory               = Spawners::Factories::LidsFactory.new(self)
      @locks_factory              = Spawners::Factories::LocksFactory.new(self)
      @writing_implements_factory = Spawners::Factories::WritingImplementsFactory.new(self)
      @books_factory              = Spawners::Factories::BooksFactory.new(self)
      @ink_sources_factory        = Spawners::Factories::InkSourcesFactory.new(self)
    end

    def initialize_outfitters
      Rails.logger.info("Initializing outfitters.")
      @characters_outfitter = Spawners::Outfitters::CharactersOutfitter.new(self)
      @items_outfitter = Spawners::Outfitters::ItemsOutfitter.new(self)
    end

    def initialize_referrers
      Rails.logger.info("Initializing referrers.")
      @attribute_bonus_referrer = Referrers::AttributeBonusReferrer.new
      @category_rank_referrer   = Referrers::CategoryRankReferrer.new
      @rank_referrer            = Referrers::RankReferrer.new
      @skill_category_referrer  = Referrers::SkillCategoryReferrer.new
      @skill_referrer           = Referrers::SkillReferrer.new
      @protection_referrer      = Referrers::ProtectionReferrer.new
      @attack_referrer          = Referrers::AttackReferrer.new
      @base_frame_referrer      = Referrers::BaseFrameReferrer.new
      @frame_modifier_referrer  = Referrers::FrameModifierReferrer.new
    end

    def initialize_timer
      Rails.logger.info("Initializing timer.")
      @timer = Periodic::Timer.new(self)
    end

    def terminate_handlers
      @superareas_handler.bye
      @areas_handler.bye
      @rooms_handler.bye
      @items_handler.bye
      @furnitures_handler.bye
      @doors_handler.bye
      @entities_handler.bye
      @characters_handler.bye
    end

    def terminate_timer
      @timer.bye
    end

    def initialize_arena
      @arena_master = Arena::ArenaMaster.new(self)
    end
  end
end
