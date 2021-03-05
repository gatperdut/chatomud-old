class CreateLids < ActiveRecord::Migration[6.0]
  def change
    create_table :lids do |t|
      t.boolean :open, null: false, default: false

      t.references :inventory, null: false, index: true
    end
  end
end
