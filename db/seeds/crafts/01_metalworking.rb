# craft weaponcraft subcraft spearheads command forge
#  opening:
#  race:
# sectors:
# seasons:
# weather:
#   phase
#     1st:  You use $1 to immerse $2 in $3.
#     3rd:  $n uses $1 to immerse $2 in $3.
#       t:  35

#       1:  (held C97541)
#       2:  (used C97393)
#       3:  (in-room C98031)
#   phase
#     1st:  When the metal is orange-hot, you pull it out of the fire, bring it to $4, and begin hammering it with $5.
#     3rd:  When the metal is orange-hot, $n pulls it out of the fire, brings it to $4, and begins hammering it with $5.
#       t:  50

#       4:  (in-room C5268 C97757)
#       5:  (held C97995 C5266)
#   phase
# 1stfail:  You shape each spearhead, but the metal is brittle -- your tempering makes them shatter.
# 3rdfail:  $n shapes the spearheads, but they shatter when tempered. $e stops working.
#     1st:  You shape several spearheads and tangs.
#     3rd:  $n shapes several spearheads and tangs.
#       t:  45

#   skill:  Metalcraft vs 1d30
#   phase
#     1st:  You immerse each piece in the hot coals, tempering and drawing the metal's brittleness out.
#     3rd:  $n immerses each piece in the hot coals, tempering and drawing the metal's brittleness out.
#       t:  45

#   phase
#     1st:  You set $6 aside.
#     3rd:  $n sets $6 aside.
#       t:  10

#       6:  (produced x4 C97044)

Craft.create!(
  category: "forge",
  name: "iron-spearheads",
  craft_ingredients: [
    # a pair of thick iron tongs
    CraftIngredient.new(
      item_template_codes: ["C97541"],
      location: :held,
      how_many: 1,
      usage_type: :reusable
    ),
    # an ingot of iron
    CraftIngredient.new(
      item_template_codes: ["C97393"],
      location: :in_room,
      how_many: 2,
      usage_type: :gone
    ),
    # a charcoal fire in the forge
    CraftIngredient.new(
      item_template_codes: ["C98031"],
      location: :in_room,
      how_many: 1,
      usage_type: :reusable
    ),
    # a rough, dull iron anvil | a black iron anvil
    CraftIngredient.new(
      item_template_codes: ["C5268", "C97757"],
      location: :in_room,
      how_many: 1,
      usage_type: :reusable
    ),
    # a blacksmith's hammer | an iron, metal-working hammer
    CraftIngredient.new(
      item_template_codes: ["C97995", "C5266"],
      location: :held,
      how_many: 1,
      usage_type: :reusable
    )
  ],
  craft_steps: [
    CraftStep.new(
      echo_first: "You use $1 to immerse $2 in $3.",
      echo_third: "$crafter uses $1 to immerse $2 in $3.",
      delay: 5
    ),
    CraftStep.new(
      echo_first: "When the metal is orange-hot, you pull it out of the fire, bring it to $4, and begin hammering it with $5.",
      echo_third: "When the metal is orange-hot, $crafter pulls it out of the fire, brings it to $4, and begins hammering it with $5.",
      delay: 5
    ),
    CraftStep.new(
      echo_first: "You shape several spearheads with tangs.",
      echo_third: "$crafter shapes several spearheads with tangs.",
      fail_first: "You shape each spearhead, but the metal is brittle -- your tempering makes them shatter. You stop working.",
      fail_third: "$crafter shapes the spearheads, but they shatter when tempered. $pronoun stops working.",
      craft_test: CraftTest.new(
        skill: :metalworking,
        modifier: 70
      ),
      delay: 5
    ),
    CraftStep.new(
      echo_first: "You immerse each piece in the hot coals, tempering and drawing the metal's brittleness out.",
      echo_third: "$crafter immerses each piece in the hot coals, tempering and drawing the metal's brittleness out.",
      delay: 5
    ),
    CraftStep.new(
      echo_first: "You set $result1 aside.",
      echo_third: "$crafter sets $result1 aside.",
      delay: 5,
      craft_item_results: [
        CraftItemResult.new(
          item_template_code: "C97044",
          how_many: 6
        )
      ]
    )
  ]
)
