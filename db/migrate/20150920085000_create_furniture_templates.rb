class CreateFurnitureTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :furniture_templates do |t|
      t.string :short_desc, null: false
      t.string :long_desc,  null: false
      t.text   :full_desc,  null: false
      t.string :kwords, null: false, array: true, default: [].to_yaml

      t.string :code, null: false

      t.integer :max_seats, null: false, default: 0
    end
  end
end
