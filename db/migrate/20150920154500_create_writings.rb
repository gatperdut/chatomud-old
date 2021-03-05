class CreateWritings < ActiveRecord::Migration[6.0]
  def change
    create_table :writings do |t|
      t.references :item, null: false, index: true

      t.boolean :wipeable, null: false, default: false
    end
  end
end
