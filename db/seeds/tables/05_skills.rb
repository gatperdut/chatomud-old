## Melee
Skill.create!(name: :light_edge,     skill_category: :melee, dependencies: [:dex, :int, :agi])
Skill.create!(name: :medium_edge,    skill_category: :melee, dependencies: [:dex, :int, :agi])
Skill.create!(name: :heavy_edge,     skill_category: :melee, dependencies: [:str, :agi, :dex])
Skill.create!(name: :medium_blunt,   skill_category: :melee, dependencies: [:str, :str, :agi])
Skill.create!(name: :heavy_blunt,    skill_category: :melee, dependencies: [:str, :str, :agi])
Skill.create!(name: :light_pierce,   skill_category: :melee, dependencies: [:str, :str, :agi])
Skill.create!(name: :medium_pierce,  skill_category: :melee, dependencies: [:str, :str, :agi])
Skill.create!(name: :polearm,        skill_category: :melee, dependencies: [:str, :str, :agi])

## Martial
Skill.create!(name: :armor_use,  skill_category: :martial, dependencies: [:agi, :str, :agi])
Skill.create!(name: :block,      skill_category: :martial, dependencies: [:str, :dex, :wil])
Skill.create!(name: :parry,      skill_category: :martial, dependencies: [:dex, :agi, :int])
Skill.create!(name: :dual_wield, skill_category: :martial, dependencies: [:dex, :dex, :int])
Skill.create!(name: :throwing,   skill_category: :martial, dependencies: [:agi, :dex, :dex])

## Ranged
Skill.create!(name: :archery,  skill_category: :ranged, dependencies: [:dex, :dex, :int]) # in CSV
Skill.create!(name: :crossbow, skill_category: :ranged, dependencies: [:dex, :int, :int])

## Athletics
Skill.create!(name: :body_development, skill_category: :athletics,         dependencies: [:con, :con, :pow])
Skill.create!(name: :brawl,            skill_category: :athletics,         dependencies: [:str, :agi, :dex]) # in CSV
Skill.create!(name: :dodge,            skill_category: :athletics,         dependencies: [:agi, :pow, :dex])

## Communication
Skill.create!(name: :quenya,        skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :telerin,       skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :sindarin,      skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :adunaic,       skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :westron,       skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :rohirric,      skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :khuzdul,       skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :entish,        skill_category: :communication, dependencies: [:wil, :wil, :wil])
Skill.create!(name: :valarin,       skill_category: :communication, dependencies: [:pow, :int, :wil])
Skill.create!(name: :black_speech,  skill_category: :communication, dependencies: [:int, :wil, :wil])
Skill.create!(name: :cirth,         skill_category: :communication, dependencies: [:dex, :wil, :int])
Skill.create!(name: :sarati,        skill_category: :communication, dependencies: [:dex, :wil, :int])
Skill.create!(name: :tengwar,       skill_category: :communication, dependencies: [:dex, :wil, :int])

## Forging
Skill.create!(name: :metalworking, skill_category: :forging, dependencies: [:str, :dex, :str])
