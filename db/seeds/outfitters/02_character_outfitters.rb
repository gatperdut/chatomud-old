CharacterOutfitter.create!(
  code: "cute_01",
  item_template_codes: {
    head: [:cap_01],
    rwrist: [
      {
        sheath_01: [:weap_02]
      }
    ],
    lhand: [
      {
        cont_02: [:food_01]
      }
    ],
    rhand: [:shield_01]
  }
)

CharacterOutfitter.create!(
  code: "gothakra_01",
  item_template_codes: {
    torso: [:armor_01],
    head: [:helm_01],
    legs: [:armor_02],
    # rwrist: [
    #   {
    #     sheath_01: [:weap_02]
    #   }
    # ],
    lhand: [:shield_01],
    wrhand: [:weap_02]
  }
)
