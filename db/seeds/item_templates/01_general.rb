ItemTemplate.create!(
  short_desc: "a tiny skull-shaped key",
  long_desc: "It's hard to spot a tiny, skull-shaped key on the ground.",
  full_desc: "A grinning skull adorns the handle of this tiny key. What may it open?",
  kwords: ["tiny", "skull-shaped", "key"],
  code: "key_01",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a small wooden chest",
  long_desc: "A small wooden chest has been left here.",
  full_desc: "This wooden chest could hold jewels - it has a lock, too.",
  kwords: ["small", "wooden", "chest"],
  code: "cont_01",
  weight: 100,
  inventory_template: InventoryTemplate.new(
    lid_template: LidTemplate.new(
      lock_template: LockTemplate.new
    )
  )
)

ItemTemplate.create!(
  short_desc: "a shiny diamond",
  long_desc: "A shiny diamond belongs to noone on the ground.",
  full_desc: "Multifaceted and pretty.",
  kwords: ["diamond", "shiny"],
  code: "prest_01",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a dirt-encrusted, rusty key",
  long_desc: "A dirt-encrusted key rusts here.",
  full_desc: "This key looks to not have been seen any use for a long time.",
  kwords: ["dirt-encrusted", "rusty", "key", "rusts"],
  code: "key_02",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a deer-leather strap",
  long_desc: "Here there is a small deer-leather strap.",
  full_desc: "You could wear this deer-leather strap around your wrists or ankles, if you are into that kind of thing.",
  kwords: ["small", "deer-leather", "leather", "strap"],
  possible_slots: [:lwrist, :rwrist, :lankle, :rankle],
  code: "deco_01",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a dog-leather wrist sheath",
  long_desc: "A dog-leather wrist sheath has been discarded here.",
  full_desc: "You could hide a small blade in this dog-leather sheath.",
  kwords: ["dog-leather", "leather", "wrist", "sheath"],
  possible_slots: [:lwrist, :rwrist],
  is_sheath: true,
  inventory_template: InventoryTemplate.new,
  code: "sheath_01",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a tiny jingling bell",
  long_desc: "A tiny jingling bell makes no sound where it lies forgotten here.",
  full_desc: "The leather strap it is attached to would allow one to wear it in either wrists or ankles, annoying people when moving around.",
  kwords: ["tiny", "jingling", "bell"],
  possible_slots: [:lwrist, :rwrist, :lankle, :rankle],
  code: "deco_02",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a plastic flute",
  long_desc: "A plastic flute lies discarded on the ground.",
  full_desc: "Fancy playing a few notes with this plastic flute?",
  kwords: ["plastic", "flute"],
  code: "misc_01",
  weight: 100
)

ItemTemplate.create!(
  short_desc: "a burlap sack",
  long_desc: "There is a burlap sack here",
  full_desc: "This sack is made of burlap, ideal for holding a few things.",
  kwords: ["burlap", "sack", "rough"],
  code: "cont_02",
  weight: 100,
  inventory_template: InventoryTemplate.new
)

ItemTemplate.create!(
  short_desc: "a metal crate",
  long_desc: "There is a metal crate here.",
  full_desc: "The metal crate has some nasty, rough edges - be careful while manipulating it.",
  kwords: ["metal", "crate"],
  code: "cont_03",
  weight: 100,
  inventory_template: InventoryTemplate.new
)

ItemTemplate.create!(
  short_desc: "a nondescript pouch",
  long_desc: "There is nondescript pouch here.",
  full_desc: "The nondescript pouch is exactly that - nondescript.",
  kwords: ["nondescript", "pouch"],
  code: "cont_04",
  weight: 100,
  inventory_template: InventoryTemplate.new
)

ItemTemplate.create!(
  short_desc: "a ham sandwich",
  long_desc: "A hitherto delicious ham sandwich gathers dust on the ground.",
  full_desc: "It is waiting for someone to pick it up and eat it.",
  kwords: ["ham", "sandwich"],
  code: "food_01",
  weight: 100,
  stack: AmountTemplate.new(
    current: 1,
    max: 10
  ),
  food: AmountTemplate.new(
    current: 4,
    max: 4,
    amount_data_template: AmountDataTemplate.new(
      calories: 400,
      hydration: 0
    )
  )
)

ItemTemplate.create!(
  short_desc: "a cow-leather waterskin",
  long_desc: "A cow-leather waterskin lies on the ground.",
  full_desc: "This cow-leather waterskin would be ideal for your long treks in the forests.",
  kwords: ["cow-leather", "leather", "waterskin"],
  code: "water_01",
  weight: 100,
  fluid: AmountTemplate.new(
    current: 14,
    max: 16,
    amount_data_template: AmountDataTemplate.new(
      fluid: :wine
    )
  )
)

ItemTemplate.create!(
  short_desc: "a generic corpse",
  long_desc: "A generic corpse has been left here. Quickly, ask and admin to get rid of it!",
  full_desc: "You are not supposed to be seeing this.",
  kwords: ["the_generic_corpse"],
  code: "corpse_01",
  weight: 100,
  inventory_template: InventoryTemplate.new
)

ItemTemplate.create!(
  short_desc: "a brown leather harness",
  long_desc: "A brown leather harness lies in a heap here.",
  full_desc: "This brown leather harness is ideal for slinging it over one of the shoulders and carrying a single weapon.",
  kwords: ["brown", "leather", "harness"],
  code: "harn_01",
  weight: 100,
  possible_slots: [:lshoulder, :rshoulder],
  is_sheath: true,
  inventory_template: InventoryTemplate.new
)
