CharacterTemplate.create!(
  short_desc: "a generic green goblin",
  long_desc: "A generic, green goblin lurks around.",
  full_desc: "These goblins roam the mud in abundance. Beware!",
  code: "gob_01",
  physical_attr_template: PhysicalAttrTemplate.new(
    genders: [:male, :female],
    race: :orc,
    height_category: :average_height,
    weight_category: :slender
  ),
  health_template: HealthTemplate.new,
  names: ["Usz", "Priok", "Strybs", "Brix", "Eang", "Vrolteabs", "Strievrig", "Groilzat", "Crudielk", "Vrodsuts"],
  noun: "goblin",
  choice_template: ChoiceTemplate.new(
    stance:        :normal,
    pace:          :walk,
    editor_echoes: false,
    language:      :black_speech,
    script:        :cirth
  ),
  aasm_template: AasmTemplate.new(
    code: :aggro
  ),
  attribute_set_template: AttributeSetTemplate.new(
    preference: [:agi, :dex, :str, :con, :pow, :wil, :int]
  ),
  skill_set_template: SkillSetTemplate.new(
    chosen: [:light_edge, :body_development, :medium_pierce]
  ),
  short_descs: [
    "long-eared",
    "cross-eyed",
    "greenish-grey",
    "long-limbed",
    "heavily-scarred",
    "yellow-teethed",
    "flat-eared",
    "tattooed",
    "mossy-green skinned",
    "mangled"
  ],
  long_desc_endings: [
    "is present",
    "patrols the area",
    "lurks about",
    "is here"
  ]
)
