class CreateSkillSets < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_sets do |t|
      t.references :character, null: false, index: true

      ## Skill Categories
      t.integer :melee,         null: false, default: 0
      t.integer :ranged,        null: false, default: 0
      t.integer :martial,       null: false, default: 0
      t.integer :athletics,     null: false, default: 0
      t.integer :communication, null: false, default: 0
      t.integer :forging,       null: false, default: 0

      ## Skills
      # Melee
      t.integer :light_edge,    null: false, default: 0
      t.integer :medium_edge,   null: false, default: 0
      t.integer :heavy_edge,    null: false, default: 0
      t.integer :medium_blunt,  null: false, default: 0
      t.integer :heavy_blunt,   null: false, default: 0
      t.integer :light_pierce,  null: false, default: 0
      t.integer :medium_pierce, null: false, default: 0
      t.integer :polearm,       null: false, default: 0

      # Ranged
      t.integer :archery,  null: false, default: 0
      t.integer :crossbow, null: false, default: 0

      # Martial
      t.integer :armor_use,  null: false, default: 0
      t.integer :block,      null: false, default: 0
      t.integer :parry,      null: false, default: 0
      t.integer :dual_wield, null: false, default: 0
      t.integer :throwing,   null: false, default: 0

      # Athletics
      t.integer :body_development, null: false, default: 0
      t.integer :dodge,            null: false, default: 0
      t.integer :brawl,            null: false, default: 0

      # Communication
      t.integer :quenya,       null: false, default: 0
      t.integer :telerin,      null: false, default: 0
      t.integer :sindarin,     null: false, default: 0
      t.integer :adunaic,      null: false, default: 0
      t.integer :westron,      null: false, default: 0
      t.integer :rohirric,     null: false, default: 0
      t.integer :khuzdul,      null: false, default: 0
      t.integer :entish,       null: false, default: 0
      t.integer :valarin,      null: false, default: 0
      t.integer :black_speech, null: false, default: 0
      t.integer :cirth,        null: false, default: 0
      t.integer :sarati,       null: false, default: 0
      t.integer :tengwar,      null: false, default: 0

      # Forging
      t.integer :metalworking, null: false, default: 0
    end
  end
end
