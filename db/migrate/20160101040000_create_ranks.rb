class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.integer :rate, null: false, default: 0

      t.integer :value, null: false
      t.integer :bonus, null: false
    end
  end
end
