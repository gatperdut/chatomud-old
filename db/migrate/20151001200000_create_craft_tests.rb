class CreateCraftTests < ActiveRecord::Migration[6.0]

  def change
    create_table :craft_tests do |t|
      t.references :craft_step, null: false, index: true

      t.integer :skill, null: false, default: 0

      t.integer :modifier, null: false
    end
  end

end
