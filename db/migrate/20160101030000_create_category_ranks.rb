class CreateCategoryRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :category_ranks do |t|
      t.integer :rate, null: false, default: 0

      t.integer :value, null: false
      t.integer :bonus, null: false
    end
  end
end
