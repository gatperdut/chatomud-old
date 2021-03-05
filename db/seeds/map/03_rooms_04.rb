a1 = Room.create!(
  title: "Western Arena",
  description: "This is the the western section of the arena.",
  description_nighttime: "This is the night description of the western section of the arena.",
  arena: true,
  inventory: Inventory.new,
  area: Area.fourth,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.2
)

a2 = Room.create!(
  title: "Eastern Arena",
  description: "This is the eastern section of the arena.",
  description_nighttime: "This is the night description of the eastern section of the arena.",
  arena: true,
  inventory: Inventory.new,
  area: Area.fourth,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.2
)

sw = Room.third

a1.update_attributes!(er: a2)
a2.update_attributes!(wr: a1, er: sw)

sw.update_attributes!(wr: a2)
