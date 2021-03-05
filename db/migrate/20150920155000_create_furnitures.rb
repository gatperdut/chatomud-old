class CreateFurnitures < ActiveRecord::Migration[6.0]
  def change
    create_table :furnitures do |t|
      t.string :short_desc, null: false
      t.string :long_desc,  null: false
      t.text   :full_desc,  null: false
      t.string :kwords, null: false, array: true, default: [].to_yaml

      t.integer :max_seats, null: false, default: 0

      t.references :room, index: true, null: false

      t.references :furniture_template, null: false, index: true
    end
  end
end
