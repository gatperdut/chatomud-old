class CreateItemOutfitters < ActiveRecord::Migration[6.0]
  def change
    create_table :item_outfitters do |t|
      t.text :item_template_codes, null: false
      t.string :code, null: false
    end
  end
end
