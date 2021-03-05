ItemOutfitter.create!(
  code: "present_01",
  item_template_codes: [
    {
      cont_01: [
        :prest_01,
        :deco_02
      ]
    },
    :deco_02
  ]
)

# 2
ItemOutfitter.create!(
  code: "present_02",
  item_template_codes: [
    :prest_01,
    :deco_02
  ]
)

# 3
ItemOutfitter.create!(
  code: "present_03",
  item_template_codes: [
    {
      cont_04: [
        :prest_01,
        :deco_02
      ]
    },
    :deco_02
  ]
)
