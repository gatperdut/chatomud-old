class CreateAttributeBonus < ActiveRecord::Migration[6.0]
  def change
    create_table :attribute_bonus do |t|
      t.integer :limit, null: false
      t.integer :bonus, null: false
      t.string :label, null: false
    end
  end
end
