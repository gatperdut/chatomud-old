Item.create!(
  short_desc: "a rusty lantern",
  long_desc: "A rusty lantern is looking for a new owner.",
  full_desc: "Does this thing even work?",
  kwords: ["rusty", "lantern"],
  possible_slots: [],
  slot: :void,
  weight: 2000,
  containing_inventory: Room.find(1).inventory,
  light_source: LightSource.new(
    capacity: Amount.new(
      current:  0,
      max:     40,
      amount_data: AmountData.new(
        fluid: :oil
      )
    ),
    efficiency: 720,
    burndown:   720,
    lit: false,
    must_be_held_to_light: true,
    liquid_fuel_req: LiquidFuelReq.new(
      options: [:oil]
    )
  ),
  item_template: ItemTemplate.find_by_code("light_01")
)

Item.create!(
  short_desc: "a soot-covered chimney",
  long_desc: "A soot-covered chimney takes up a corner of the room.",
  full_desc: "Perfect for sharing stories near it.",
  kwords: ["soot-covered", "chimney"],
  possible_slots: [],
  slot: :void,
  weight: 300_000,
  containing_inventory: Room.find(3).inventory,
  light_source: LightSource.new(
    capacity: Amount.new(
      current:  0,
      max:     10
    ),
    efficiency: 1440,
    burndown:   1440,
    lit: false,
    must_be_held_to_light: false,
    solid_fuel_req: SolidFuelReq.new(
      options: [ItemTemplate.find_by_code("fuel_01")]
    )
  ),
  item_template: ItemTemplate.find_by_code("light_02")
)

Item.create!(
  short_desc: "an orb",
  long_desc: "An orb shines on the ground.",
  full_desc: "Shiiiiny.",
  kwords: ["orb"],
  slot: :void,
  weight: 0,
  containing_inventory: Room.find(1).inventory,
  light_source: LightSource.new(
    lit: true
  ),
  item_template: ItemTemplate.find_by_code("light_03")
)

Item.create!(
  short_desc: "a torch",
  long_desc: "A torch in a corner makes it all appear untidy.",
  full_desc: "It is oiled and ready to be put to the fire.",
  kwords: ["torch"],
  slot: :void,
  weight: 300,
  containing_inventory: Room.find(1).inventory,
  light_source: LightSource.new(
    capacity: Amount.new(
      current: 1,
      max: 1
    ),
    efficiency: 20,
    burndown:   20,
    lit: false,
    must_be_held_to_light: true
  ),
  item_template: ItemTemplate.find_by_code("light_04")
)
