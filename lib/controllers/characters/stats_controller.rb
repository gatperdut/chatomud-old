require "mixins/characters/skill_set/definition"
require "mixins/characters/skill_set/utils"

require "mixins/characters/attribute_set/definition"
require "mixins/characters/attribute_set/utils/general"
require "mixins/characters/attribute_set/utils/agility"
require "mixins/characters/attribute_set/utils/constitution"

require "mixins/characters/stats/combat/melee/offense"
require "mixins/characters/stats/combat/melee/defense"
require "mixins/characters/stats/combat/ranged/offense"
require "mixins/characters/stats/combat/ranged/defense"

require "mixins/characters/choices/stances/utils"

require "mixins/armor/definition"
require "mixins/armor/utils"

module ChatoMud
  module Controllers
    module Characters
      class StatsController
        extend Mixins::Characters::AttributeSet::Definition
        extend Mixins::Characters::SkillSet::Definition
        extend Mixins::Armor::Definition

        include Mixins::Characters::AttributeSet::Utils::General
        include Mixins::Characters::AttributeSet::Utils::Agility
        include Mixins::Characters::AttributeSet::Utils::Constitution
        include Mixins::Characters::Stats::Combat::Melee::Offense
        include Mixins::Characters::Stats::Combat::Melee::Defense
        include Mixins::Characters::Stats::Combat::Ranged::Offense
        include Mixins::Characters::Stats::Combat::Ranged::Defense
        include Mixins::Characters::SkillSet::Utils

        include ChatoMud::Mixins::Characters::Choices::Stances::Utils

        def initialize(server, character_controller, attribute_set, skill_set)
          @server = server
          @character_controller = character_controller
          @attribute_set = attribute_set
          @skill_set = skill_set
        end

        def reload_model
          @attribute_set = AttributeSet.find(@attribute_set.id)
          @skill_set     = SkillSet.find(@skill_set.id)
        end

        private

        def combat_controller
          @character_controller.combat_controller
        end

        def health_controller
          @character_controller.health_controller
        end

        def encumbrance_controller
          @character_controller.encumbrance_controller
        end

        def nourishment_controller
          @character_controller.nourishment_controller
        end

        def inventory_controller
          @character_controller.inventory_controller
        end

        def category_rank_referrer
          @server.category_rank_referrer
        end

        def rank_referrer
          @server.rank_referrer
        end

        def skill_category_referrer
          @server.skill_category_referrer
        end

        def skill_referrer
          @server.skill_referrer
        end

        def attribute_bonus_referrer
          @server.attribute_bonus_referrer
        end

        def protection_referrer
          @server.protection_referrer
        end
      end
    end
  end
end
