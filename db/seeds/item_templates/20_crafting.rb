# #C97541
# tongs pair thick iron tool METAL~
# a pair of thick iron tongs~
# A pair of thick iron tongs lies on the ground.~
#    It is a pair of thick, iron tongs with two loops of metal at
# one end as handles and curved hooks at the other end for
# gripping.
ItemTemplate.create!(
  short_desc: "a pair of thick iron tongs",
  long_desc: "A pair of thick iron tongs lies on the ground.",
  full_desc: "It is a pair of thick, iron tongs with two loops of metal at one end as handles and curved hooks at the other end for gripping.",
  kwords: ["tongs", "pair", "thick", "iron", "tool"],
  code: "C97541",
  weight: 100
)

# #C97393
# iron ingot metal_craft METAL~
# an ingot of iron~
# An ingot of iron sets here on the ground.~
#    A small, yet heavy square of iron, this iron bar is the basic
# tool used by smiths to create their work.
# ~
# 48 4198400 1
# 0 0 0 0
# 250 0.000000
# 0 0 0 30 134217728 0 1
# 36.000000 0 0 0 17 0 0
ItemTemplate.create!(
  short_desc: "an ingot of iron",
  long_desc: "An ingot of iron sits here on the ground.",
  full_desc: "A small, yet heavy square of iron, this bar is the basic tool used by smiths to create their work.",
  kwords: ["ingot"],
  stack: AmountTemplate.new(
    current: 10,
    max: 10
  ),
  code: "C97393",
  weight: 100
)

# #C98031
# fire forge CRAFT_ITEM charcoal metal_craft METAL~
# #1a charcoal fire in the forge#0~
# #1A charcoal fire burns in the forge.#0~
# This charcoal fire burns brightly inside the forge.
# ~
# 1 4096 0
# 6 6 54 1
# 100 0.000000
# 0 0 0 0 0 0 1
# 0.000000 6 1651 0 28 0 0
ItemTemplate.create!(
  short_desc: "a charcoal fire in the forge",
  long_desc: "A charcoal fire burns in the forge.",
  full_desc: "This charcoal fire burns brightly inside the forge.",
  kwords: ["fire", "forge"],
  code: "C98031",
  weight: 100
)

# #C5268
# anvil dull rough iron heavy METAL~
# a rough, dull iron anvil~
# A rough, dull iron anvil stands here.~
#    Standing roughly at knee-height, this iron anvil has been cast large enough so that repetitive hammer-strikes do not budge it from its position. It is flat on the top, and there are several curved or otherwise different geometric surfaces on the sides that would allow the smith to forge any shape of his choosing. It is dullish gray in color, the glossiness having been faulted by multitudes of scratches.
ItemTemplate.create!(
  short_desc: "a rough, dull iron anvil",
  long_desc: "A rough, dull iron anvil stands here.",
  full_desc: "Standing roughly at knee-height, this iron anvil has been cast large enough so that repetitive hammer-strikes do not budge it from its position. It is flat on the top, and there are several curved or otherwise different geometric surfaces on the sides that would allow the smith to forge any shape of his choosing. It is dullish gray in color, the glossiness having been faulted by multitudes of scratches.",
  kwords: ["anvil", "dull", "rough", "iron"],
  code: "C5268",
  weight: 100
)

# #C97757
# anvil iron black metal_craft METAL~
# a black iron anvil~
# A black iron anvil sits on the ground.~
#    Standing roughly at knee-height, this iron anvil has been cast large enough so that repetitive hammer-strikes do not budge it from its position. It is flat on the top, and there are several curved or otherwise different geometric surfaces on the sides that would allow the smith to forge any shape of his choosing. It is dullish gray in color, the glossiness having been faulted by multitudes of scratches.
ItemTemplate.create!(
  short_desc: "a black iron anvil",
  long_desc: "A black iron anvil sits on the ground.",
  full_desc: "Standing roughly at knee-height, this iron anvil has been cast large enough so that repetitive hammer-strikes do not budge it from its position. It is flat on the top, and there are several curved or otherwise different geometric surfaces on the sides that would allow the smith to forge any shape of his choosing. It is dullish gray in color, the glossiness having been faulted by multitudes of scratches.",
  kwords: ["anvil", "black", "iron"],
  code: "C97757",
  weight: 100
)

# #C97995
# hammer blacksmith metal_craft tool METAL~
# a blacksmith's hammer~
# A blacksmith's hammer lies on the ground here.~
#    Slightly larger and heavier than a normal hammer, this hammer is used by smith's in their craft. The head is large and scuffed up. The handle is made of wood. The entire tool appears to have been worn and used.
ItemTemplate.create!(
  short_desc: "a blacksmith's hammer",
  long_desc: "A blacksmith's hammer lies on the ground here.",
  full_desc: "Slightly larger and heavier than a normal hammer, this hammer is used by smith's in their craft. The head is large and scuffed up. The handle is made of wood. The entire tool appears to have been worn and used.",
  kwords: ["hammer", "blacksmith"],
  code: "C97995",
  weight: 100
)

# #C5266
# hammer iron metalcraft tool METAL~
# an iron, metal-working hammer~
# An iron, metal-working hammer has been discarded here.~
#    The head of this smith's hammer has been forged from iron, and carefully sanded into a smooth cylindrical shape. The handle is built out of heavy ironwood, giving the hammer strength, while protecting the wielder from the heat of the head. Part of the hammer has turned black from exposure to the soot in the fires.

ItemTemplate.create!(
  short_desc: "an iron, metal-working hammer",
  long_desc: "An iron, metal-working hammer has been discarded here.",
  full_desc: "The head of this smith's hammer has been forged from iron, and carefully sanded into a smooth cylindrical shape. The handle is built out of heavy ironwood, giving the hammer strength, while protecting the wielder from the heat of the head. Part of the hammer has turned black from exposure to the soot in the fires.",
  kwords: ["hammer", "metal-working", "tool"],
  code: "C5266",
  weight: 100
)

# #C97044
# spearhead SIMPLE head iron weapon_craft METAL~
# an iron spearhead~
# An iron spearhead has been set here.~
#    It's a vaguely diamond-shaped spearhead made of cast-iron, with an elongated point. The butt of the piece is slightly pointed, so it can be mounted to a shaft.
ItemTemplate.create!(
  short_desc: "an iron spearhead",
  long_desc: "An iron spearhead has been set here.",
  full_desc: "It's a vaguely diamond-shaped spearhead made of iron, with an elongated point. The butt of the piece is slightly pointed, so it can be mounted to a shaft.",
  kwords: ["iron", "spearhead", "head"],
  stack: AmountTemplate.new(
    current: 6,
    max: 6
  ),
  code: "C97044",
  weight: 100
)
