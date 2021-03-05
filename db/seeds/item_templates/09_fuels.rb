ItemTemplate.create!(
  short_desc: "a lump of coal",
  long_desc: "A lump of coal is on the ground.",
  full_desc: "It will stain your clothes",
  kwords: ["lump", "coal"],
  code: "fuel_01",
  weight: 100,
  stack: AmountTemplate.new(
    current: 1,
    max: 100
  )
)

ItemTemplate.create!(
  short_desc: "a wax-sealed clay bottle",
  long_desc: "A wax-sealed clay bottle rests on the ground.",
  full_desc: "This is a sealed clay bottle which could contain some liquid.",
  kwords: ["wax-sealed", "clay", "bottle"],
  code: "fuel_02",
  weight: 100,
  fluid: AmountTemplate.new(
    current: 8,
    max: 20,
    amount_data_template: AmountDataTemplate.new(
      fluid: :oil
    )
  )
)

ItemTemplate.create!(
  short_desc: "a great barrel",
  long_desc: "A great barrel takes up a lot of room.",
  full_desc: "Pretty freaking big.",
  kwords: ["great", "barrel"],
  code: "fuel_03",
  weight: 30_000,
  fluid: AmountTemplate.new(
    current: 98,
    max: 100,
    amount_data_template: AmountDataTemplate.new(
      fluid: :oil
    )
  )
)
