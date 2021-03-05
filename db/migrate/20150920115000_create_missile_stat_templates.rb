class CreateMissileStatTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :missile_stat_templates do |t|
      t.references :item_template, null: false, index: true

      t.integer :missile_type, null: false, default: 0
    end
  end
end
