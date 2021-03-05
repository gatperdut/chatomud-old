class CreateWeaponStats < ActiveRecord::Migration[6.0]
  def change
    create_table :weapon_stats do |t|
      t.references :item, index: true

      t.integer :grip, null: false, default: 0

      t.integer :roll_mod, null: false, default: 0     # added to attack rolls   (higher: better attacks)

      t.integer :critical_mod, null: false, default: 0 # added to critical rolls (higher: greater criticals)

      t.integer :base, null: false
    end
  end
end
