module ChatoMud
  module Mixins
    module Characters
      module SkillSet
        module Definition
          def all_skill_labels
            [
              :unskilled,
              :beginner,
              :novice,
              :amateur,
              :familiar,
              :talented,
              :adroit,
              :master,
              :grandmaster,
              :heroic,
              :godlike
            ]
          end

          def all_rank_rates
            [
              :limited,
              :below_average,
              :standard,
              :above_average,
              :plus
            ]
          end
          alias all_category_rank_rates all_rank_rates

          def all_skills
            all_melee_skills         +
            all_ranged_skills        +
            all_martial_skills       +
            all_athletics_skills     +
            all_communication_skills +
            all_forging_skills
          end

          def all_skills_and_skill_categories
            all_skills + all_skill_categories
          end

          def all_weapon_skills
            all_melee_skills + all_ranged_skills
          end

          def all_skill_categories
            [
              :melee,

              :ranged,

              :martial,

              :athletics,

              :communication,

              :forging
            ]
          end

          def all_melee_skills
            [
              :light_edge,
              :medium_edge,
              :heavy_edge,
              :medium_blunt,
              :heavy_blunt,
              :light_pierce,
              :medium_pierce,
              :polearm
            ]
          end

          def all_ranged_skills
            [
              :archery,
              :crossbow
            ]
          end

          def all_martial_skills
            [
              :armor_use,
              :block,
              :parry,
              :dual_wield,
              :throwing
            ]
          end

          def all_athletics_skills
            [
              :body_development,
              :dodge,
              :brawl
            ]
          end

          def all_communication_skills
            all_language_skills + all_script_skills
          end

          def all_language_skills
            [
              :quenya,
              :telerin,
              :sindarin,
              :adunaic,
              :westron,
              :rohirric,
              :khuzdul,
              :entish,
              :valarin,
              :black_speech
            ]
          end

          def all_script_skills
            [
              :cirth,
              :sarati,
              :tengwar
            ]
          end

          def all_forging_skills
            [
              :metalworking
            ]
          end
        end
      end
    end
  end
end
