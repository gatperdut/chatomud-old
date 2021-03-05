require "mixins/characters/skill_set/utils"
require "controllers/items/melee_stat_controller"
require "controllers/items/ranged_stat_controller"

module ChatoMud
  module Controllers
    module Items
      class WeaponStatController
        include Mixins::Characters::SkillSet::Utils

        attr_reader :melee_stat_controller
        attr_reader :ranged_stat_controller

        def initialize(server, item_controller, weapon_stat)
          @server = server
          @item_controller = item_controller
          @weapon_stat = weapon_stat

          @melee_stat_controller  = weapon_stat.melee_stat  ? MeleeStatController.new(server, self, weapon_stat.melee_stat) : nil
          @ranged_stat_controller = weapon_stat.ranged_stat ? RangedStatController.new(server, self, weapon_stat.ranged_stat) : nil
        end

        def is_ranged?
          !!@ranged_stat_controller
        end

        def is_melee?
          !!@melee_stat_controller
        end

        def is_one_handed?
          grip == :one_handed
        end

        def is_one_or_two_handed?
          is_one_handed? || grip == :both
        end

        def is_two_handed?
          grip == :two_handed
        end

        def hands_requirement
          return "a free hand" if is_one_or_two_handed?
          return "both hands free" if is_two_handed?
        end

        def grip
          @weapon_stat.grip.to_sym
        end

        def base
          @weapon_stat.base.to_sym
        end

        def skill_name
          skill_per_weapon_base[base]
        end

        def roll_mod
          @weapon_stat.roll_mod
        end

        def critical_mod
          @weapon_stat.critical_mod
        end
      end
    end
  end
end
