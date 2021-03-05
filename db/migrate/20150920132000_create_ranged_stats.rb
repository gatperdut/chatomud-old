class CreateRangedStats < ActiveRecord::Migration[6.0]
  def change
    create_table :ranged_stats do |t|
      t.references :weapon_stat, index: true

      t.integer :missile_type, null: false, default: 0

      t.string :ranges_suitability, null: false, array: true, default: [].to_yaml

      t.boolean :can_remain_loaded, default: false, null: false
    end
  end
end
