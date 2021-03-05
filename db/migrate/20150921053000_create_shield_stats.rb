class CreateShieldStats < ActiveRecord::Migration[6.0]
  def change
    create_table :shield_stats do |t|
      t.references :item, index: true

      t.integer :variant, null: false, default: 0

      t.integer :quality_modifier, null: false, default: 0
    end
  end
end
