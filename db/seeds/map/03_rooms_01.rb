nw = Room.create!(
  title: "NW Room",
  description: "This is the northwestern room.",
  description_nighttime: "This is the night description of the northwestern room.",
  inventory: Inventory.new,
  area: Area.first,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

ne = Room.create!(
  title: "NE Room",
  description: "This is the northeastern room.",
  description_nighttime: "This is the night description of the northeastern room.",
  inventory: Inventory.new,
  area: Area.first,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

sw = Room.create!(
  title: "SW Room",
  description: "This is the southwestern room.",
  description_nighttime: "This is the night description of the southwestern room.",
  inventory: Inventory.new,
  area: Area.first,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

se = Room.create!(
  title: "SE Room",
  description: "This is the southeastern room.",
  description_nighttime: "This is the night description of the southeastern room.",
  inventory: Inventory.new,
  area: Area.first,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

u = Room.create!(
  title: "The attic",
  description: "This is the attic.",
  description_nighttime: nil,
  inventory: Inventory.new,
  area: Area.first,
  always_lit: true,
  enclosed: false,
  roughness_multiplier: 1.5
)

d = Room.create!(
  title: "Cellar",
  description: "This is the cellar. Beware of monsters in the dark.",
  description_nighttime: "This is the night description of the cellar.",
  inventory: Inventory.new,
  area: Area.first,
  always_lit: false,
  enclosed: true,
  roughness_multiplier: 2.0
)

nw.update_attributes!(er: ne, sr: sw, ur: u, dr: d)

ne.update_attributes!(wr: nw, sr: se)

sw.update_attributes!(nr: nw, er: se)

se.update_attributes!(nr: ne, wr: sw)

u.update_attributes!(dr: nw)

d.update_attributes!(ur: nw)
