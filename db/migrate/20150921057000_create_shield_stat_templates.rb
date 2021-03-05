class CreateShieldStatTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :shield_stat_templates do |t|
      t.references :item_template, null: false, index: true

      t.integer :variant, null: false, default: 0

      t.integer :quality_modifier, null: false, default: 0
    end
  end
end
