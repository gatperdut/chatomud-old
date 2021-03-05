require "mixins/characters/skill_set/definition"

module ChatoMud
  module Mixins
    module Characters
      module SkillSet
        module Utils
          include Mixins::Characters::SkillSet::Definition

          def list_skill_set
            text = ""
            self.class.all_skill_categories.each do |skill_category_name|
              rank = category_rank(skill_category_name)

              next if rank.unskilled?

              text << "#{skill_category_name.to_s.magenta}"
              text << " (#{rank.value} ranks, #{category_modifier(skill_category_name)})"
              text << " (total #{category_modifier(skill_category_name)})"
              text << " (#{rank.rate})\n"
              skills = skill_referrer.group_by(skill_category_name)
              skills.each do |skill|
                skill_name = skill.name.to_sym
                rank = skill_rank(skill_name)
                next if rank.value.zero?

                text << "  #{skill_name.to_s.cyan} (#{skill_modifier_label(skill_name)})"
                text << " (#{rank.value} ranks, #{rank.bonus})"
                text << " (#{category_modifier(skill_category_name)} category)"
                text << " (total #{skill_modifier(skill_name)})"
                text << " (#{rank.rate})\n"
              end
            end
            text
          end

          def rank_for(skill_name)
            @skill_set.send(skill_name)
          end
          alias category_rank_for rank_for

          def category_modifier(skill_category_name)
            skill_category_rank = category_rank(skill_category_name)

            skill_category_rank.bonus
          end

          def skill_modifier(skill_name)
            skill_name_sym = skill_name.to_sym

            skill = skill_referrer.find(skill_name_sym)
            skill_category_name = skill.skill_category.to_sym

            category_modifier(skill_category_name) + skill_rank(skill_name_sym).bonus
          end

          def knows_skill?(skill_name)
            skill_modifier(skill_name) >= 10
          end

          def skill_modifier_label(skill_name)
            all_skill_labels[skill_modifier(skill_name) / 10]
          end

          def category_rank(skill_category_name)
            category_rank_referrer.find(category_rate(skill_category_name), category_rank_for(skill_category_name))
          end

          def skill_rank(skill_name)
            rank_referrer.find(skill_rate(skill_name), rank_for(skill_name))
          end

          def category_rate(skill_category_name)
            rate(skill_category_referrer.find(skill_category_name).dependencies)
          end

          def skill_rate(skill_name)
            rate(skill_referrer.find(skill_name).dependencies)
          end

          private

          def rate(dependencies)
            attribute_values = dependencies.map do |dependency|
              attribute_value(dependency)
            end
            attribute_values_mean = (attribute_values.inject(:+) / 3.0).round

            case attribute_values_mean
              when 1..15
                :limited
              when 16..35
                :below_average
              when 36..65
                :standard
              when 66..85
                :above_average
              when 86..100
                :plus
              else
                raise "invalid attribute values mean"
            end
          end

          def skill_per_weapon_base
            {
              dagger:       :light_edge,

              shortsword:   :medium_edge,
              falchion:     :medium_edge,
              handaxe:      :medium_edge,
              scimitar:     :medium_edge,
              battleaxe:    :medium_edge,

              longsword:    :heavy_edge,
              broadsword:   :heavy_edge,
              greatsword:   :heavy_edge,

              quarterstaff: :medium_blunt,
              warhammer:    :medium_blunt,
              club:         :medium_blunt,
              mace:         :medium_blunt,

              morningstar:  :heavy_blunt,
              flail:        :heavy_blunt,
              warmattock:   :heavy_blunt,

              stiletto:     :light_pierce,

              rapier:       :medium_pierce,

              javelin:      :polearm,
              spear:        :polearm,
              lance:        :polearm,

              shortbow:     :archery,
              longbow:      :archery,

              crossbow:     :crossbow,

              brawl:        :brawl
            }
          end
        end
      end
    end
  end
end
