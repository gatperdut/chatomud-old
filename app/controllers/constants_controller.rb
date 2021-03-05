require "mixins/characters/skill_set/utils"

require "mixins/grips/definition"
require "mixins/characters/skill_set/definition"
require "mixins/ranges/definition"
require "mixins/missile/definition"

require "mixins/slots/definition"
require "mixins/armor/definition"
require "mixins/weapons/definition"
require "mixins/body_parts/definition"

require "mixins/fluids/definition"

require "mixins/crafts/ingredients/definition"

class ConstantsController < ApplicationController
  include ChatoMud::Mixins::Characters::SkillSet::Utils

  include ChatoMud::Mixins::Grips::Definition
  include ChatoMud::Mixins::Characters::SkillSet::Definition
  include ChatoMud::Mixins::Ranges::Definition
  include ChatoMud::Mixins::Missile::Definition

  include ChatoMud::Mixins::Slots::Definition
  include ChatoMud::Mixins::Armor::Definition
  include ChatoMud::Mixins::Weapons::Definition
  include ChatoMud::Mixins::BodyParts::Definition

  include ChatoMud::Mixins::Fluids::Definition

  include ChatoMud::Mixins::Crafts::Ingredients::Definition

  def weapons
    render json: {
      grips:           all_grips,
      melee_bases:     all_melee_bases,
      ranged_bases:    all_ranged_bases,
      all_bases:       all_weapon_bases,
      melee_skills:    all_melee_skills,
      ranged_skills:   all_ranged_skills,
      skills_per_base: skill_per_weapon_base,
      missile_types:   all_missile_types,
      missile_ranges:  all_ranges
    }
  end

  def armor
    render json: {
      slots:                     regular_slots,
      body_parts:                all_body_parts,
      maneuver_impediments:      all_maneuver_impediments,
      ranged_attack_impediments: all_ranged_attack_impediments
    }
  end

  def fluids
    render json: all_fluids
  end

  def ingredients
    render json: {
      usage_types: all_craft_ingredient_usage_types,
      locations:   all_craft_ingredient_locations
    }
  end

  def skills
    render json: {
      all: Skill.all,
      labels: all_skill_labels,
      ranks: {
        limited:       Rank.where(rate: "limited"),
        below_average: Rank.where(rate: "below_average"),
        standard:      Rank.where(rate: "standard"),
        above_average: Rank.where(rate: "above_average"),
        plus:          Rank.where(rate: "plus")
      }
    }
  end

  def skill_categories
    render json: {
      all: SkillCategory.all,
      ranks: {
        limited:       CategoryRank.where(rate: "limited"),
        below_average: CategoryRank.where(rate: "below_average"),
        standard:      CategoryRank.where(rate: "standard"),
        above_average: CategoryRank.where(rate: "above_average"),
        plus:          CategoryRank.where(rate: "plus")
      }
    }
  end

  def attributes
    render json: AttributeBonus.all
  end
end
