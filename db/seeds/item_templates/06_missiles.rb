ItemTemplate.create!(
  short_desc: "an iron-tipped arrow",
  long_desc: "An iron-tipped arrow is on the ground.",
  full_desc: "Sharpy sharp!",
  kwords: ["iron-tipped", "arrow"],
  code: "weap_01",
  weight: 80,
  stack: AmountTemplate.new(
    current: 1,
    max: 100
  ),
  missile_stat_template: MissileStatTemplate.new(
    missile_type: :arrow
  )
)

ItemTemplate.create!(
  short_desc: "an iron bolt",
  long_desc: "An iron bolt is on the ground",
  full_desc: "Sharpy sharpererrrr!",
  kwords: ["iron", "bolt"],
  code: "weap_04",
  weight: 80,
  stack: AmountTemplate.new(
    current: 1,
    max: 100
  ),
  missile_stat_template: MissileStatTemplate.new(
    missile_type: :bolt
  )
)
