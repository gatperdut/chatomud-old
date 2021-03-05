module ChatoMud
  module Mixins
    module Weapons
      module Definition
        def all_weapon_bases
          all_melee_bases + all_ranged_bases
        end

        def all_melee_bases
          [
            :dagger,
            :shortsword,
            :falchion,
            :handaxe,
            :scimitar,
            :battleaxe,
            :longsword,
            :broadsword,
            :greatsword,
            :quarterstaff,
            :warhammer,
            :club,
            :mace,
            :morningstar,
            :flail,
            :warmattock,
            :stiletto,
            :rapier,
            :javelin,
            :spear,
            :lance,
            :brawl
          ]
        end

        def all_ranged_bases
          [
            :shortbow,
            :longbow,
            :crossbow
          ]
        end
      end
    end
  end
end
