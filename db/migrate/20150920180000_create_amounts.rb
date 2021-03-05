class CreateAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :amounts do |t|
      t.integer :current, null: false

      t.integer :max, null: false

      t.references :stackable, null: true, index: true

      t.references :edible,    null: true, index: true

      t.references :fillable,  null: true, index: true

      t.references :fuelable,  null: true, index: true
    end
  end
end
