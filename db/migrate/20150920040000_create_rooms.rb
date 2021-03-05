class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :title, null: false

      t.text :description, null: false

      t.text :description_nighttime

      t.references :area,  null: false, index: true

      t.boolean :arena, null: false, default: false

      t.boolean :always_lit, null: false, default: false

      t.boolean :enclosed, null: false, default: false

      t.float :roughness_multiplier, null: false, default: 1.0

      t.references :nr,  null: true, index: true
      t.references :er,  null: true, index: true
      t.references :sr,  null: true, index: true
      t.references :wr,  null: true, index: true
      t.references :ur,  null: true, index: true
      t.references :dr,  null: true, index: true

      t.references :nd,  null: true, index: true
      t.references :ed,  null: true, index: true
      t.references :sd,  null: true, index: true
      t.references :wd,  null: true, index: true
      t.references :ud,  null: true, index: true
      t.references :dd,  null: true, index: true
    end
  end
end
