ItemTemplate.create!(
  short_desc: "a fine, steel dagger",
  long_desc: "A steel dagger of fine make has been discarded here.",
  full_desc: "This fine, steel dagger could inflict some damage.",
  kwords: ["dagger"],
  code: "weap_02",
  weight: 1000,
  possible_slots: [],
  weapon_stat_template: WeaponStatTemplate.new(
    grip: :one_handed,
    base: :dagger,
    roll_mod: 0,
    critical_mod: 0,
    melee_stat_template: MeleeStatTemplate.new(
      sheathed_desc: "a dagger"
    )
  )
)

ItemTemplate.create!(
  short_desc: "a blunt, iron longsword",
  long_desc: "A blunt, iron longsword lies on the ground.",
  full_desc: "It is made of iron, but it is quite blunt. Still dangerous, though? Yes.",
  kwords: ["blunt", "iron", "longsword", "sword"],
  code: "weap_03",
  weight: 1000,
  weapon_stat_template: WeaponStatTemplate.new(
    grip: :both,
    base: :longsword,
    roll_mod: 0,
    critical_mod: 0,
    melee_stat_template: MeleeStatTemplate.new(
      sheathed_desc: "a longsword"
    )
  )
)

ItemTemplate.create!(
  short_desc: "a heavy, scary greatsword",
  long_desc: "A heavy, scary greatsword has been left here.",
  full_desc: "Huge. Most likely you will need two hands to wield this beast of a weapon.",
  kwords: ["heavy", "scary", "greatsword"],
  code: "weap_05",
  weight: 1000,
  possible_slots: [],
  weapon_stat_template: WeaponStatTemplate.new(
    grip: :two_handed,
    base: :greatsword,
    roll_mod: 0,
    critical_mod: 0,
    melee_stat_template: MeleeStatTemplate.new(
      sheathed_desc: "a greatsword"
    )
  )
)
