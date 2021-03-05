ItemTemplate.create!(
  short_desc: "a rusty lantern",
  long_desc: "A rusty lantern is looking for a new owner.",
  full_desc: "Does this thing even work?",
  kwords: ["rusty", "lantern"],
  possible_slots: [],
  code: "light_01",
  weight: 2000,
  light_source_template: LightSourceTemplate.new(
    capacity: AmountTemplate.new(
      current:  0,
      max:     40,
      amount_data_template: AmountDataTemplate.new(
        fluid: :oil
      )
    ),
    liquid_fuel_req_template: LiquidFuelReqTemplate.new(
      options: [:oil]
    ),
    efficiency: 720,
    burndown:   720,
    lit: false,
    must_be_held_to_light: true
  )
)

ItemTemplate.create!(
  short_desc: "a soot-covered chimney",
  long_desc: "A soot-covered chimney takes up a corner of the room.",
  full_desc: "Perfect for sharing stories near it.",
  kwords: ["soot-covered", "chimney"],
  possible_slots: [],
  code: "light_02",
  weight: 300_000,
  light_source_template: LightSourceTemplate.new(
    capacity: AmountTemplate.new(
      current:  0,
      max:     10
    ),
    solid_fuel_req_template: SolidFuelReqTemplate.new(
      options: [ItemTemplate.find_by_code("fuel_01")]
    ),
    efficiency: 1440,
    burndown:   1440,
    lit: false,
    must_be_held_to_light: false
  )
)

ItemTemplate.create!(
  short_desc: "an orb",
  long_desc: "An orb shines on the ground.",
  full_desc: "Shiiiiny.",
  kwords: ["orb"],
  possible_slots: [],
  code: "light_03",
  weight: 0,
  light_source_template: LightSourceTemplate.new(
    lit: true
  )
)

ItemTemplate.create!(
  short_desc: "a torch",
  long_desc: "A torch in a corner makes it all appear untidy.",
  full_desc: "It is oiled and ready to be put to the fire.",
  kwords: ["torch"],
  possible_slots: [],
  code: "light_04",
  weight: 300,
  light_source_template: LightSourceTemplate.new(
    capacity: AmountTemplate.new(
      current: 1,
      max:     1
    ),
    efficiency: 20,
    burndown:   20,
    lit: false,
    must_be_held_to_light: true
  )
)
