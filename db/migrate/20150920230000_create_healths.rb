class CreateHealths < ActiveRecord::Migration[6.0]
  def change
    create_table :healths do |t|
      t.references :character, null: false, index: true

      t.integer :exhaustion, null: false, default: 0
    end
  end
end
