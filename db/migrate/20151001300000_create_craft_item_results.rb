class CreateCraftItemResults < ActiveRecord::Migration[6.0]

  def change
    create_table :craft_item_results do |t|
      t.references :craft_step, null: false, index: true

      t.string :item_template_code, null: false

      t.integer :how_many

      t.integer :skill
    end
  end

end
