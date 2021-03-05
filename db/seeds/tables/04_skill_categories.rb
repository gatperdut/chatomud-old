SkillCategory.create!(name: :melee,         dependencies: [:str, :agi, :dex])

SkillCategory.create!(name: :ranged,        dependencies: [:dex, :dex, :int])

SkillCategory.create!(name: :martial,       dependencies: [:str, :agi, :con])

SkillCategory.create!(name: :athletics,     dependencies: [:str, :con, :agi])

SkillCategory.create!(name: :communication, dependencies: [:int, :int, :wil])

SkillCategory.create!(name: :forging,       dependencies: [:str, :con, :int])
