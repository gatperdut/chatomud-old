Character.create!(
  name: "Halred",
  short_desc: "a straw-colored, wavy-haired young man",
  long_desc: "A straw-haired, wavy-haired young man is here.",
  full_desc: "One of the many guards in the area. He looks ready for combat.",
  kwords: ["halred", "straw-colored", "colored", "wavy-haired", "haired", "young", "man"],
  physical_attr: PhysicalAttr.new(
    gender: :male,
    race: :human,
    height: 170,
    weight: 70
  ),
  npc: true,
  room: Room.find(1),
  inventory: Inventory.new,
  aasm: Aasm.new(
    code: :wanderer,
    active: true
  ),
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
    pace:     :walk,
    editor_echoes: false,
    language: :westron,
    script:   :tengwar
  ),
  health: Health.new(
    exhaustion: 35
  ),
  skill_set: SkillSet.new(
    # Skill Categories
    melee:         10,
    ranged:        10,
    martial:       10,
    athletics:     10,
    communication:  8,
    forging:       10,

    # Skills
    light_edge:    10,
    medium_edge:   10,
    heavy_edge:    10,
    medium_blunt:  10,
    heavy_blunt:   10,
    light_pierce:  10,
    medium_pierce: 10,
    polearm: 10,

    archery:       10,
    crossbow:      10,

    armor_use:     10,
    block:         10,
    parry:         10,
    dual_wield:    10,
    throwing:      10,

    body_development: 10,
    brawl:            10,
    dodge:            10,

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
