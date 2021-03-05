class CreateArmorStats < ActiveRecord::Migration[6.0]
  def change
    create_table :armor_stats do |t|
      t.references :item, index: true

      t.integer :protection_level, null: false

      t.integer :penalty_level, null: false

      t.integer :roll_mod, null: false, default: 0     # added to attack rolls   (lower: better protection)

      t.integer :critical_mod, null: false, default: 0 # added to critical rolls (lower: lesser criticals)

      t.integer :maneuver_impediment, null: false

      t.integer :ranged_attack_impediment, null: false

      t.string :body_parts, null: false, array: true, default: [].to_yaml
    end
  end
end
