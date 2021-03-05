Character.create!(
  name: "Gunnbjorn",
  short_desc: "a strapping man with a blond beard",
  long_desc: "A strapping man with a blond beard is here.",
  full_desc: "This is Gunns full description.",
  kwords: ["gunnbjorn", "strapping", "blond", "beard", "man"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 198,
    weight: 95
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(1),
  room: Room.find(1),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 92,
    con: 90,
    agi: 90,
    dex: 95,
    int: 93,
    wil: 90,
    pow: 92
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35,
    wounds: [
      Wound.new(damage: 8, damage_type: :slash, body_part: :rthigh, inventory: nil),
      Wound.new(damage: 25, damage_type: :crush, body_part: :face, inventory: nil)
    ]
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         24,
    ranged:        24,
    martial:       24,
    athletics:     24,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    24,
    medium_edge:   24,
    heavy_edge:    24,
    medium_blunt:  24,
    heavy_blunt:   24,
    light_pierce:  24,
    medium_pierce: 24,
    polearm:       24,

    archery:  24,
    crossbow: 24,

    armor_use:  24,
    block:      24,
    parry:      24,
    dual_wield: 24,
    throwing:   24,

    body_development: 24,
    brawl:            24,
    dodge:            24,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "Irzan",
  short_desc: "an olive-toned man with a pointy beard",
  long_desc: "An olive-toned man with a pointy beard is here.",
  full_desc: "This is Irzans description.",
  kwords: ["irzan", "olive-toned", "pointy", "beard", "man"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 165,
    weight: 59
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(2),
  room: Room.find(1),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 92,
    con: 90,
    agi: 90,
    dex: 95,
    int: 93,
    wil: 90,
    pow: 92
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         23,
    ranged:        23,
    martial:       23,
    athletics:     23,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    23,
    medium_edge:   23,
    heavy_edge:    23,
    medium_blunt:  23,
    heavy_blunt:   23,
    light_pierce:  23,
    medium_pierce: 23,
    polearm:       23,

    archery:  23,
    crossbow: 23,

    armor_use:  23,
    block:      23,
    parry:      23,
    dual_wield: 23,
    throwing:   23,

    body_development: 23,
    brawl:            23,
    dodge:            23,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "Shianek",
  short_desc: "an able-bodied woman with knife-cropped hair",
  long_desc: "An able-bodied woman with knife-cropped hair is here.",
  full_desc: "This is Shianeks description.",
  kwords: ["shianek", "able-bodied", "knife-cropped", "woman"],
  physical_attr: PhysicalAttr.new(
    gender: :female,
    race: :human,
    height: 175,
    weight: 69
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  gifts: [:infravision],
  active: true,
  player: Player.find(3),
  room: Room.find(3),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 90,
    con: 90,
    agi: 90,
    dex: 95,
    int: 93,
    wil: 90,
    pow: 92
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: true,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         22,
    ranged:        20,
    martial:       20,
    athletics:     20,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    22,
    medium_edge:   20,
    heavy_edge:    20,
    medium_blunt:  19,
    heavy_blunt:   20,
    light_pierce:  22,
    medium_pierce: 20,
    polearm:       20,

    archery:  20,
    crossbow: 20,

    armor_use:  20,
    block:      20,
    parry:      20,
    dual_wield: 20,
    throwing:   20,

    body_development: 10,
    brawl:            20,
    dodge:            20,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "someone",
  short_desc: "someone",
  long_desc: "Someone is here.",
  full_desc: "There is someone here.",
  kwords: ["someone"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 177,
    weight: 72
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(4),
  room: Room.find(1),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 70,
    con: 60,
    agi: 50,
    dex: 55,
    int: 33,
    wil: 80,
    pow: 52
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         20,
    ranged:        19,
    martial:       10,
    athletics:     10,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    20,
    medium_edge:   23,
    heavy_edge:    19,
    medium_blunt:  11,
    heavy_blunt:   10,
    light_pierce:  12,
    medium_pierce: 10,
    polearm:       10,

    archery: 14,
    crossbow: 5,

    armor_use:  10,
    block:      10,
    parry:      10,
    dual_wield: 10,
    throwing:   10,

    body_development: 16,
    brawl:            10,
    dodge:            20,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "Godigisel",
  short_desc: "a hunchbacked, muscled man",
  long_desc: "An hunchbacked, muscled man is here.",
  full_desc: "Though he might be taller were his flesh and bone more typical, this person is forced to hunch a few inches above average, with noticeable asymmetry to the slope of his shoulders, the shape of his chest, and the curve of his spine. The right arm and deltoid is somewhat bulkier than the left, but both are laden heavily with muscle. His hands are particularly gnarly things, no stranger to endless toil. For his proportion, his feet are small and his legs stout, imposing on him an awkward gait. His face isn't particularly pretty, either - oily, bumpy nose, scarred - except for his eyes. Clear, attentive, they're the brightest of blues.",
  kwords: ["godigisel", "hunchbacked", "man", "muscled"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 185,
    weight: 83
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(5),
  room: Room.find(1),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 70,
    con: 60,
    agi: 50,
    dex: 55,
    int: 33,
    wil: 80,
    pow: 52
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         20,
    ranged:        19,
    martial:       10,
    athletics:     10,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    20,
    medium_edge:   23,
    heavy_edge:    19,
    medium_blunt:  11,
    heavy_blunt:   10,
    light_pierce:  12,
    medium_pierce: 10,
    polearm:       10,

    archery: 14,
    crossbow: 5,

    armor_use:  10,
    block:      10,
    parry:      10,
    dual_wield: 10,
    throwing:   10,

    body_development: 16,
    brawl: 10,
    dodge: 20,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "bob",
  short_desc: "bob",
  long_desc: "test bob plz ignore.",
  full_desc: "Ignore me!!",
  kwords: ["bob"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 125,
    weight: 30
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(6),
  room: Room.find(3),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 90,
    con: 90,
    agi: 90,
    dex: 95,
    int: 93,
    wil: 90,
    pow: 92
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         22,
    ranged:        20,
    martial:       20,
    athletics:     20,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    22,
    medium_edge:   20,
    heavy_edge:    20,
    medium_blunt:  19,
    heavy_blunt:   20,
    light_pierce:  22,
    medium_pierce: 20,
    polearm: 20,

    archery:  20,
    crossbow: 20,

    armor_use:  20,
    block:      20,
    parry:      20,
    dual_wield: 20,
    throwing:   20,

    body_development: 10,
    brawl: 20,
    dodge: 20,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    metalworking: 15
  )
)

Character.create!(
  name: "Mahunga",
  short_desc: "a disabled, shady man",
  long_desc: "A disabled, shady man is here.",
  full_desc: "This is Mahungas full desc.",
  kwords: ["mahunga", "disabled", "shady", "man"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :troll,
    height: 265,
    weight: 259
  ),
  nourishment: Nourishment.new(
    calories: 500,
    hydration: 1000
  ),
  active: true,
  player: Player.find(7),
  room: Room.find(1),
  inventory: Inventory.new,
  attribute_set: AttributeSet.new(
    str: 92,
    con: 90,
    agi: 90,
    dex: 95,
    int: 93,
    wil: 90,
    pow: 92
  ),
  choice: Choice.new(
    stance:   :normal,
    pace: :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    wounds: [
      Wound.new(damage: 8, damage_type: :slash, body_part: :rthigh, inventory: nil),
      Wound.new(damage: 25, damage_type: :crush, body_part: :face, inventory: nil)
    ]
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         24,
    ranged:        24,
    martial:       24,
    athletics:     24,
    communication: 10,
    forging:       10,

    # Skills
    light_edge:    24,
    medium_edge:   24,
    heavy_edge:    24,
    medium_blunt:  24,
    heavy_blunt:   24,
    light_pierce:  24,
    medium_pierce: 24,
    polearm:       24,

    archery:  24,
    crossbow: 24,

    armor_use:  24,
    block:      24,
    parry:      24,
    dual_wield: 24,
    throwing:   24,

    quenya:       10,
    telerin:      10,
    sindarin:     10,
    adunaic:      10,
    westron:      10,
    rohirric:     10,
    khuzdul:      10,
    entish:       10,
    valarin:      10,
    black_speech: 10,
    cirth:        10,
    sarati:       10,
    tengwar:      10,

    body_development: 24,
    brawl:            24,
    dodge:            24,

    metalworking: 15
  )
)
