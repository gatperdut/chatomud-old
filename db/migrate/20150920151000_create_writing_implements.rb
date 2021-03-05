class CreateWritingImplements < ActiveRecord::Migration[6.0]
  def change
    create_table :writing_implements do |t|
      t.references :item, null: false, index: true

      t.boolean :charged, null: false, default: false

      t.integer :ink_type, null: false, default: 0

      t.boolean :single_use, null: false, default: false
    end
  end
end
