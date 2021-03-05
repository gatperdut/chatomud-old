nw = Room.first
ne = Room.second
d  = Room.find(6)
sw = Room.third

nw_ne = Door.create!(
  short_desc: "door",
  long_desc: "a wooden door",
  full_desc: "Your regular wooden door. Not fancy.",
  see_through: false,
  wr_id: nw.id,
  er_id: ne.id
)

nw_d = Door.create!(
  short_desc: "grate",
  long_desc: "a metal grate",
  full_desc: "A reinforced metal grate, with a lock. Looks sturdy.",
  lock: Lock.new(
    locked: true
  ),
  see_through: true,
  ur_id: nw.id,
  dr_id: d.id
)

nw_sw = Door.create!(
  short_desc: "gate",
  long_desc: "an ornated gate",
  full_desc: "You almost feel like saying -friend- in front of it.",
  see_through: true,
  nr_id: nw.id,
  sr_id: sw.id
)

nw.update_attributes(ed_id: nw_ne.id, dd_id: nw_d.id, sd_id: nw_sw.id)
ne.update_attributes(wd_id: nw_ne.id)
d.update_attributes(ud_id: nw_d.id)
sw.update_attributes(nd_id: nw_sw.id)
