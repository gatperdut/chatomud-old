class CreateMissileStats < ActiveRecord::Migration[6.0]
  def change
    create_table :missile_stats do |t|
      t.references :item, index: true

      t.integer :missile_type, null: false, default: 0
    end
  end
end
