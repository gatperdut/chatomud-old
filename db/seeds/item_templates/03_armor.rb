ItemTemplate.create!(
  short_desc: "a shoddy iron cap",
  long_desc: "A shoddy iron cap rests in a heap here.",
  full_desc: "This shoddy iron cap will cover the head.",
  kwords: ["shoddy", "iron", "cap"],
  possible_slots: [:head],
  code: "cap_01",
  weight: 5000,
  armor_stat_template: ArmorStatTemplate.new(
    protection_level: 16,
    penalty_level: 18,
    roll_mod: 20,
    critical_mod: 5,
    body_parts: [:head, :face],
    maneuver_impediment: :lowest_mi,
    ranged_attack_impediment: :no_rai
  )
)

ItemTemplate.create!(
  short_desc: "a pair of well-fitting, leather gloves",
  long_desc: "A pair of well-fitting, leather gloves wait for someone to pick them up.",
  full_desc: "These well-fitting, leather gloves will cover the hands.",
  kwords: ["well-fitting", "leather", "pair", "gloves"],
  possible_slots: [:hands],
  code: "glove_01",
  weight: 5000,
  armor_stat_template: ArmorStatTemplate.new(
    protection_level: 6,
    penalty_level: 5,
    roll_mod: 0,
    critical_mod: -5,
    body_parts: [:lhand, :rhand],
    maneuver_impediment: :lowest_mi,
    ranged_attack_impediment: :high_rai
  )
)

ItemTemplate.create!(
  short_desc: "a polished, steel spangen-helm",
  long_desc: "A polished, steel spangen-helm sits on the ground",
  full_desc: "Look it up in google. Really. I do not feel like writing an elaborate description right now for this polished, steel spangen-helm.",
  kwords: ["polished", "steel", "spangen-helm", "helm"],
  possible_slots: [:head],
  code: "helm_01",
  weight: 5000,
  armor_stat_template: ArmorStatTemplate.new(
    protection_level: 18,
    penalty_level: 17,
    roll_mod: -5,
    critical_mod: -10,
    body_parts: [:head, :face],
    maneuver_impediment: :lowest_mi,
    ranged_attack_impediment: :no_rai
  )
)

ItemTemplate.create!(
  short_desc: "a run-of-the-mill shirt of iron chainmail",
  long_desc: "A run-of-the-mill shirt of iron chainmail is here, folded.",
  full_desc: "Iron. Run-of-the-mill. Chainmail. Were you expecting a detailed description?",
  kwords: ["run-of-the-mill", "iron", "shirt", "chainmail"],
  possible_slots: [:torso],
  code: "armor_01",
  weight: 5000,
  armor_stat_template: ArmorStatTemplate.new(
    protection_level: 6,
    penalty_level: 5,
    roll_mod: 0,
    critical_mod: -5,
    body_parts: [:chest, :abdomen, :lside, :rside, :back, :lshoulder, :rshoulder, :larm, :rarm, :lhip, :rhip],
    maneuver_impediment: :highest_mi,
    ranged_attack_impediment: :medium_rai
  )
)

ItemTemplate.create!(
  short_desc: "a bulky pair of leather leggings",
  long_desc: "Some bulky, leather leggings have been left aside.",
  full_desc: "These bulky, leather leggings look fit for Freddy Mercury.",
  kwords: ["bulky", "leather", "pair", "leggings"],
  possible_slots: [:legs],
  code: "armor_02",
  weight: 5000,
  armor_stat_template: ArmorStatTemplate.new(
    protection_level: 7,
    penalty_level: 8,
    roll_mod: 0,
    critical_mod: -5,
    body_parts: [:groin, :lhip, :rhip, :lthigh, :rthigh, :lknee, :rknee, :lshin, :rshin, :lankle, :rankle],
    maneuver_impediment: :high_mi,
    ranged_attack_impediment: :no_rai
  )
)
