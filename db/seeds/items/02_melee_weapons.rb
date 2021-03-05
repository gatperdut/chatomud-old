Item.create!(
  short_desc: "a rusty iron longsword",
  long_desc: "A longsword covered in rust lies on the ground.",
  full_desc: "Rusty und battered? Yes. Dangerous? Yeah, that too.",
  kwords: ["rusty", "longsword", "sword"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  weapon_stat: WeaponStat.new(
    base: :longsword,
    melee_stat: MeleeStat.new(
      sheathed_desc: "a longsword"
    )
  ),
  item_template: ItemTemplate.find_by_code("weap_03")
)

Item.create!(
  short_desc: "a steel greatsword",
  long_desc: "A steel greatsword has been left here.",
  full_desc: "Huge and sharp. Most likely you will need to hands to wield this cumbersome weapon.",
  kwords: ["steel", "greatsword"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  weapon_stat: WeaponStat.new(
    grip: :two_handed,
    base: :greatsword,
    melee_stat: MeleeStat.new(
      sheathed_desc: "a greatsword"
    )
  ),
  item_template: ItemTemplate.find_by_code("weap_05")
)

Item.create!(
  short_desc: "a serrated dagger",
  long_desc: "A dagger with a serrated edge has been discarded here.",
  full_desc: "It possesses a serrated edge, designed for maximum damage.",
  kwords: ["serrated", "dagger"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  weapon_stat: WeaponStat.new(
    grip: :one_handed,
    base: :dagger,
    melee_stat: MeleeStat.new(
      sheathed_desc: "a dagger"
    )
  ),
  item_template: ItemTemplate.find_by_code("weap_02")
)

Item.create!(
  short_desc: "a serrated dagger",
  long_desc: "A dagger with a serrated edge has been discarded here.",
  full_desc: "It possesses a serrated edge, designed for maximum damage.",
  kwords: ["serrated", "dagger"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  weapon_stat: WeaponStat.new(
    grip: :one_handed,
    base: :dagger,
    melee_stat: MeleeStat.new(
      sheathed_desc: "a dagger"
    )
  ),
  item_template: ItemTemplate.find_by_code("weap_02")
)
