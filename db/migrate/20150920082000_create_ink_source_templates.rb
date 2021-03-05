class CreateInkSourceTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :ink_source_templates do |t|
      t.references :item_template, null: false, index: true

      t.references :spawned_item_template, null: true, index: true

      t.integer :ink_type, null: false, default: 0

      t.integer :charges, null: false, default: 0
    end
  end
end
