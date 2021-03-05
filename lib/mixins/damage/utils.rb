require "mixins/random/utils"

module ChatoMud
  module Mixins
    module Damage
      module Utils
        include Mixins::Random::Utils

        def regular_damage_type_for(type)
          json =
            case type
              when :dagger
                { puncture: 70, slash: 30 }
              when :shortsword
                { slash: 60, puncture: 30 }
              when :longsword
                { slash: 80, puncture: 20 }
              when :broadsword
                { slash: 70, crush: 10, puncture: 20 }
              when :falchion
                { slash: 80, crush: 5, puncture: 15 }
              when :handaxe
                { slash: 90, crush: 10 }
              when :scimitar
                { slash: 90, puncture: 10 }
              when :battleaxe
                { slash: 75, crush: 25 }
              when :greatsword
                { slash: 85, crush: 15 }
              when :quarterstaff
                { crush: 100 }
              when :warhammer
                { crush: 80, puncture: 20 }
              when :club
                { crush: 100 }
              when :mace
                { crush: 100 }
              when :morningstar
                { crush: 80, puncture: 20 }
              when :flail
                { crush: 100 }
              when :warmattock
                { crush: 100 }
              when :rapier
                { puncture: 100 }
              when :stiletto
                { puncture: 80, slash: 20 }
              when :javelin
                { puncture: 100 }
              when :spear
                { puncture: 100 }
              when :lance
                { puncture: 100 }
              when :brawl
                { hand_to_hand: 100 }
              when :shortbow
                { puncture: 100 }
              when :longbow
                { puncture: 100 }
              when :crossbow
                { puncture: 100 }
              else
                raise "unknown skill name"
            end

          roll = d100(:closed)
          json.each_key do |skill|
            roll -= json[skill]
            return skill if roll <= 0
          end

          raise "check the jsons, something is wrong"
        end
      end
    end
  end
end
